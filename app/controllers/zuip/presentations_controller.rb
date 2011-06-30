class Zuip::PresentationsController < ApplicationController
  layout 'zuip'
  include Zuip::PresentationsHelper

  def show
    path = File.join([Rails.root.to_s, "public", zuip_path(params[:name])])
    begin
      @presentation = Zuip::Presentation.new(:source => path)
      render :locals => { :name => params[:name] }
    rescue Errno::ENOENT
      flash[:alert] = t("Could not open file")+": #{path}"
      redirect_to root_path
    end
  end

end
