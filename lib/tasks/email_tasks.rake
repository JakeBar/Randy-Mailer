# file: lib/tasks/email_tasks.rake

class User
  attr_accessor :login, :email, :surf_data
end

desc 'send surf report'
task send_surf_report: :environment do

  url = 'http://magicseaweed.com/api/1/forecast/?spot_id=616&fields=timestamp,swell.*,solidRating'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  result = ActiveSupport::JSON.decode(response)

  data = User.new
  data.login =  'Micky_Boi911'
  data.email = 'jake.b.dev@gmail.com'
  data.surf_data = result.last

  UserMailer.surf_report(data).deliver!
end