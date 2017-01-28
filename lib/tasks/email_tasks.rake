# file: lib/tasks/email_tasks.rake

desc 'send surf report'
task send_surf_report: :environment do
  # ... set options if any
  new_user = User.new
  new_user.name = 'Mick Fanning'
  new_user.login =  'Micky_Boi911'
  new_user.email = 'jake.b.dev@gmail.com'
  UserMailer.welcome_email(new_user).deliver!
end