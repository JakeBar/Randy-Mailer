class UserMailer < ApplicationMailer
    default from:'notifications@randy.com'

    def surf_report(user)
      @user = user
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end

    def surf_report(user)
      @user = user
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Surf Report - Randy')
    end
end
