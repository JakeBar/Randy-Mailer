require 'json'

desc 'send surf report'
task send_surf_report: :environment do
  puts 'sending surf report(s)'
  email_list = ENV['USER_LIST'] # e.g. '{"Jake":"jake.b.dev@gmail.com"}'
  if email_list
    emails = JSON.parse(email_list)
    puts emails
    emails.each do |key, value|
      UserMailer.surf_report(key, value).deliver!
    end
    puts 'done.'
  else
    puts 'ENV["USER_LIST"] not set.'
  end
end
