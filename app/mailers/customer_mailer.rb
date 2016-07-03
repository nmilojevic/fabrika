class CustomerMailer < ApplicationMailer

  default from: 'crossfit.fabrika@gmail.com'
 
  def account_approved_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "fabrika.crossfit@gmail.com"
    mail(to: @user.email, subject: 'Your account is approved')
  end

  def signup_confirmation_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "fabrika.crossfit@gmail.com"
    mail(to: @user.email, subject: 'Welcome to Fabrika!')
  end

  def new_web_site_email
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "fabrika.crossfit@gmail.com"
    mail(to: @user.email, subject: 'Fabrika ima novu aplikaciju!')
  end

  def membership_expires_soon_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "fabrika.crossfit@gmail.com"
    mail(to: @user.email, subject: 'Your membership will expire in 5 days')
  end

  def membership_expired(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "fabrika.crossfit@gmail.com"
    mail(to: @user.email, subject: 'Your membership has expired')
  end

end
