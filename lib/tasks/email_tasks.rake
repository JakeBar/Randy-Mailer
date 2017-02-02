# file: lib/tasks/email_tasks.rake

desc 'send surf report'
task send_surf_report: :environment do
  UserMailer.surf_report().deliver!
end