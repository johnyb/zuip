class Zuip::PresentationsController < ApplicationController
  layout 'zuip', :only => [:show]
  layout 'application', :except => [:show]

  def index
    @presentations = Dir.glob(zuip_path('*'))
    @presentations.map!{ |p| Zuip::Presentation.new(:source => p) }
    @presentations = @presentations.select{ |p| not p.nil? }
  end

  def show
    path = zuip_path(params[:name])
    begin
      @presentation = Zuip::Presentation.new(:source => path)
      render :locals => { :name => params[:name] }
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
