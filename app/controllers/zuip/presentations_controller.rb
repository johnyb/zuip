class Zuip::PresentationsController < ApplicationController
  layout 'zuip'
  include Zuip::PresentationsHelper

  def show
    path = File.join([Rails.root.to_s, "public", zuip_path(params[:name])])
    presentation = Zuip::Presentation.new(:source => path)
    render :locals => { :presentation => presentation, :name => params[:name] }
  end

end
