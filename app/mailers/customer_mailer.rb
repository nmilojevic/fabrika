class CustomerMailer < ApplicationMailer

  default from: 'crossfit.fabrika@gmail.com'
 
  def account_approved_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Vaš nalog je aktiviran.')
  end

  def signup_confirmation_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Dobrodošli u fabriku!')
  end

  def new_web_site_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Factory Niš mini sportska ekskurzija Takmičenje Skopje Winter Challenge')
  end

  def notify_that_event_is_created_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Factory Niš je dodao treninge za ovu nedelju')
  end

  def membership_expires_soon_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Vaša članarina je istekla, vaš nalog će biti deaktiviran za 5 dana')
  end

  def membership_expired_email(user)
    @user = user
    @email = ENV['FABRIKA_CONTACT_EMAIL'] || "crossfit.fabrika@gmail.com"
    mail(to: @user.email, subject: 'Vaš nalog je deaktiviran.')
  end

end
