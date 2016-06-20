class CustomerMailer < ApplicationMailer

  default from: 'nmilojevic@gmail.com'
 
  def account_approved_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account is approved')
  end

  def signup_confirmation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Fabrika!')
  end
end
