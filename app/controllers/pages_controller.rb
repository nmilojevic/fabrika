class PagesController < ApplicationController
  before_action :authenticate_user!
  def show
    render template: "pages/#{params[:page]}"
  end

  def schedule
    prepare_meta_tags title: "Raspored", description: "Rezervacija treninga"
    render template: "pages/schedule"
  end

  private

end
