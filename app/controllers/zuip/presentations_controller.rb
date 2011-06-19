class Zuip::PresentationsController < ApplicationController
  layout 'zuip'
  def show
    presentation = Presentation.new
    render :locals => { :presentation => presentation, :name => params[:name] }
  end

end
