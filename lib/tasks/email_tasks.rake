# file: lib/tasks/email_tasks.rake

desc 'send surf report'
task send_surf_report: :environment do
  puts "sending surf report(s)"
  emails = [["Jake@School", ENV["GMAIL_USERNAME"]],["Jake@Work","jake.b.dev@gmail.com"], ENV["GMAIL_USERNAME"]]

  emails.each do |item|
    UserMailer.surf_report(item[0], item[1]).deliver!
  end
  puts "done."
end