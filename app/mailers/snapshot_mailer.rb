class SnapshotMailer < ApplicationMailer
  default from: 'notification@sfr.fr'
  
   def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to web_monitor')
  end
end
