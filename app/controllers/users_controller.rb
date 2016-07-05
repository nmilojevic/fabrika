class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    respond_to do |format|
      format.html
      format.json{ render json: UsersDatatable.new(view_context)}

      #@users = User.all.order(:created_at)
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
    if @user.active!
      CustomerMailer.account_approved_email(@user).deliver
      redirect_to users_path, :notice => "User approved."
    else
      redirect_to users_path, :alert => "Unable to approve user."
    end
  end

  def update_membership
    @user = User.find(params[:id])
    if @user.update_attributes(membership_updated_at: params[:user][:membership_updated_at].to_date.in_time_zone)
      if @user.membership_updated_at <= (Time.current - 35.days)
        @user.expire!
      else
        @user.active!
      end
      redirect_to users_path, :notice => "User membership updated."
    else
      redirect_to users_path, :alert => "Unable to update membership subscription."
    end
  end

  def renew_membership
    @user = User.find(params[:id])
    if @user.update_attributes(membership_updated_at: Time.current)
      @user.active!
      CustomerMailer.account_approved_email(@user).deliver
      redirect_to users_path, :notice => "User membership renewed."
    else
      redirect_to users_path, :alert => "Unable to renew membership subscription."
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      render json:{success:true}
    else
      render json:{error:@user.errors.full_messages}
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
    params.require(:user).permit(:role, :membership_updated_at, :subscribed_event_types => [])
  end

end
