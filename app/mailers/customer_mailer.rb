class CustomerMailer < ApplicationMailer

  default from: 'fabrika-crossfit@gmail.com'
 
  def account_approved_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account is approved')
  end

  def signup_confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Fabrika!')
  end

  def membership_expires_soon_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your membership will expire in 5 days')
  end

  def membership_expired(user)
    @user = user
    mail(to: @user.email, subject: 'Your membership has expired')
  end

end
