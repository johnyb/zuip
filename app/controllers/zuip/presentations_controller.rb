class Zuip::PresentationsController < ApplicationController
  layout 'application', :except => [:show]

  def index
    @presentations = Dir.glob(zuip_path('*'))
    @presentations.map!{ |p| Zuip::Presentation.new(:source => p) }
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

  def show
    path = zuip_path(params[:name])
    begin
      @presentation = Zuip::Presentation.new(:source => path)
      render :locals => { :name => params[:name] }, :layout => "zuip"
    rescue Errno::ENOENT
      flash[:alert] = t("Could not open file")+": #{path}"
      redirect_to presentations_path
    end
  end

  private
  def zuip_path(name)
    name = "" if name.nil?
    File.join([Rails.root.to_s, "public/assets/zuip", name+'.svg'])
  end
end
