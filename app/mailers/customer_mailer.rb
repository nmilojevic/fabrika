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

  def send_group_email
    @users = User.all
    total = @users.size
    count = 0
    @users.each do |user|
      p "#{count}/#{total}"
      p "send email to #{user.email}"
      new_web_site_email(user).deliver
      if (count % 50) == 0
        p "sleep 30 seconds"
        sleep(30)
      end
    end
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
