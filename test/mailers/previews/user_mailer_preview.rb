# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  class User
    attr_accessor :name, :login, :email
  end

  def welcome_email
    new_user = User.new
    new_user.name = 'Mick Fanning'
    new_user.login =  'Micky_Boi911'
    new_user.email = 'jake.b.dev@gmail.com'

    UserMailer.welcome_email(new_user)
  end
end
