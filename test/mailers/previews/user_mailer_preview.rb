# Preview all emails at http://localhost:3000/rails/mailers/user_mailer

class UserMailerPreview < ActionMailer::Preview

  def surf_report
    UserMailer.surf_report()
  end
end
