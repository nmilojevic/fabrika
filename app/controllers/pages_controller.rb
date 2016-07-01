class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end

  def schedule
    render template: "pages/schedule"
  end
end
