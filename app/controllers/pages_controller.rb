class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  def show
    render template: "pages/#{params[:page]}"
  end

  def schedule
    render template: "pages/schedule"
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
end
