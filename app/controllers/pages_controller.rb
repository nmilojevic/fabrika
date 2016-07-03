class PagesController < ApplicationController
  before_action :authenticate_user!
  def show
    render template: "pages/#{params[:page]}"
  end

  def schedule
    render template: "pages/schedule"
  end

  private

end
