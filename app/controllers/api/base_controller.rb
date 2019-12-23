class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token
  before_action :authenticate_api_user!
  respond_to :json

  private

  def invalid_auth_token
    respond to do |format|
      format.html { redirect_to sign_in_path,
                    error: 'Login invalid or expired' }
      format.json { head 401 }
    end
  end

  def current_user
    current_api_user
  end
end
