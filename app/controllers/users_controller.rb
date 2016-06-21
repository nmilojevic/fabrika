class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    if params[:approved] == "false"
      @users = User.where(approved:false)
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def approve
    @user = User.find(params[:id])
     if @user.update_attributes(approved: true)
      CustomerMailer.account_approved_email(@user).deliver
      redirect_to users_path, :notice => "User approved."
    else
      redirect_to users_path, :alert => "Unable to approve user."
    end
  end

  def renew_membership
    @user = User.find(params[:id])
     if @user.update_attributes(membership_expired: false, membership_updated: Time.current)
      redirect_to users_path, :notice => "User membership renewed."
    else
      redirect_to users_path, :alert => "Unable to renew membership subscription."
    end
  end

  def update
    @user = User.find(params[:id])
    p "nikola"*1000
    p params[:user]
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end 
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :subscribed_event_types)
  end

end
