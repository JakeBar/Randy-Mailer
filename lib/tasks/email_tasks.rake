# file: lib/tasks/email_tasks.rake

desc 'send surf report'
task send_surf_report: :environment do
  puts "sending surf report(s)"
  emails = [["Jake", ENV["GMAIL_USERNAME"]],
            ["Josh",ENV["JOSH_EMAIL"]],
            ["Reuben",ENV["REUBEN_EMAIL"]],
            ["Ollie",ENV["OLLIE_EMAIL"]]
  ]

  emails.each do |item|
    UserMailer.surf_report(item[0], item[1]).deliver!
  end
  puts "done."
end