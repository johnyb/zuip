class Zuip::PresentationsController < ApplicationController
  layout 'application', :except => [:show]

  before_filter :find_presentation, :only => [:edit, :show, :update]

  def index
    @presentations = Dir.glob(zuip_path('*'))
    @presentations.map! do |p|
      begin
        Zuip::Presentation.new(:source => p)
      rescue
        nil
      end
    end
    @presentations = @presentations.select{ |p| not p.nil? }
  end

  def new
    @presentation = Zuip::Presentation.new
  end

  def create
    presentation = Zuip::Presentation.new
    presentation.title = params[:presentation][:title]
    begin
      presentation.file = zuip_path(params[:presentation][:fileName])
    rescue Errno::EEXIST
      flash[:error] = t "A Presentation with this filename already exists"
      redirect_to new_presentations_path
      return
    end
    if presentation.save
      flash[:notice] = t "Presentation created."
      redirect_to edit_presentations_path(params[:presentation][:fileName])
    else
      flash[:error] = t "Creation failed."
    end
  end

  def update
    cancel = params[:commit].include?(t(:cancel, :scope => :edit))
    redirect_to named_presentations_path(params[:name]) if cancel
    return if @presentation.nil? || cancel
    unless @presentation.fileName == params[:presentation][:fileName] then
      old_file = @presentation.fileName
      File.rename(zuip_path(old_file), zuip_path(params[:presentation][:fileName]))
      @presentation.source = zuip_path(params[:presentation][:fileName])
    end
    @presentation.title = params[:presentation][:title] unless @presentation.title == params[:presentation][:title]
    @presentation.assets = params.keys.select { |k| k =~ /^asset_\d*$/ }.map { |item| params[item] }

    @presentation.save
    redirect_to named_presentations_path(@presentation.fileName.chomp!('.svg'))
  end

  def edit
    render :locals => { :name => params[:name] } if @presentation
  end

  def show
    render :locals => { :name => params[:name] }, :layout => "zuip" if @presentation
  end

  private
  def find_presentation
    begin
      path = zuip_path(params[:name])
      @presentation = Zuip::Presentation.new(:source => path)
    rescue Errno::ENOENT
      flash[:alert] = t("Could not open file")+": #{path}"
      redirect_to presentations_path
    end
  end

  def zuip_path(name)
    raise Errno::ENOENT if name.nil?
    name.chomp!('.svg')
    File.join([Rails.root.to_s, "public/assets/zuip", name+'.svg'])
  end
end
