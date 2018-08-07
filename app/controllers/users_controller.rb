class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :admin_only, except: [:unimpersonate_user]
  respond_to :html, :json, only:[:new, :edit, :update, :create_user]

  def index
    prepare_meta_tags title: "Članovi", description: "Ažuriranje članova"
   
    @user = User.new
    respond_to do |format|
      format.html
      format.json{ render json: UsersDatatable.new(view_context)}
    end
  end

  def new
    @user = User.new
    respond_modal_with @user
  end

  def edit
    @user = User.find(params[:id])
    respond_modal_with @user
  end

  def create_user
    @user = User.create(secure_params)
    flash[:notice] = 'Novi član je uspešno dodat.'
    respond_modal_with @user, location: users_path
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
      render json:{success:true, message:t("user_approved")}
    else
      render json:{error:@user.errors.full_messages}
    end
  end

  def update_membership
    @user = User.find(params[:id])
    if @user.update_attributes(membership_updated_at: params[:user][:membership_updated_at].to_date.in_time_zone)
      if @user.membership_updated_at <= (Time.current - 35.days)
        @user.expired!
      else
        @user.active!
      end
      render json:{success:true, message:t("user_membership_updated")}
    else
      render json:{error:@user.errors.full_messages}
    end
  end

  def renew_membership
    @user = User.find(params[:id])
    if @user.update_attributes(membership_updated_at: Time.current - 5.days)
      @user.active!
      CustomerMailer.account_approved_email(@user).deliver
      render json:{success:true, message:t("user_membership_renewed")}
    else
      render json:{error:@user.errors.full_messages}
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(secure_params)
    flash[:notice] = 'Član je uspešno ažuriran.'
    respond_modal_with @user, location: users_path
    #   render json:{success:true, message:t("user_role_updated")}
    # else
    #   render json:{error:@user.errors.full_messages}
    # end 
  end

  def update_subscribed_event_types
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
       render json:{success:true, message:t("user_role_updated")}
    else
       render json:{error:@user.errors.full_messages}
    end 
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json:{success:true, message:t("user_deleted")}
  end

  def unimpersonate_user
    p "unimpersonate"
    if !session[:stack_admins].blank?
      p "session"
      new_user = User.find(session[:stack_admins].last)
      p new_user.name
      sign_in(new_user, bypass: true)
      session[:stack_admins].pop
    end
    redirect_to users_path

  end

  def impersonate
    from_user_id = current_user.id
    to_user_id = params[:id]
    session[:stack_admins] = Array.new if session[:stack_admins].blank?
    session[:stack_admins] << from_user_id
    to_user = User.find(to_user_id)
    sign_in(to_user, bypass: true)
    p "FROM USER: #{User.find(from_user_id).email}", "*" * 100
    p "STACK ADMINS: #{session[:stack_admins].inspect}"
    redirect_to schedule_path
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :password, :password_confirmation, :name, :email, :membership_updated_at, :subscribed_event_types => [])
  end

end
