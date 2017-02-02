class UserMailer < ApplicationMailer
    default from:'notifications@randy.com'

    def surf_report(user)
      @user = user
      @url  = 'http://randy.com/login'
      mail(to: @user.email, subject: 'Surf Report - Randy')
    end

    def surf_report()

      # get surf data
      url = 'http://magicseaweed.com/api/1/forecast/?spot_id=1070'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      result = ActiveSupport::JSON.decode(response)

      # store applicable data
      data = User.new
      data.login =  'Jake'
      data.email = 's3380519@student.rmit.edu.au'

      # get reports for the next 24 hours
      time = Time.now.to_i

      iterator = 0

      daily_data = Array.new
      result.each do |item|

        # if the report time has already passed,
        # OR
        # it's more than 24 hours later than local time
        # remove from the stack
        if ( (item['localTimestamp'] >= time) && (item['localTimestamp'] <= (time + 60 * 60 * 24)))
          daily_data.push(item)
        end
      end

      data.surf_data = daily_data

      swell_values = Array.new
      data.surf_data.each do |item|
        swell_values.push(item['solidRating'])
      end

      # get the average swell score
      swell_score = (swell_values.sum / swell_values.size.to_f).round

      data.swell_score = swell_score
      @user = data
      @url  = 'http://randy.com/login'

      # given that the swell score is greater than 3, send email
      # if (data.swell_score >= 3)
        mail(to: @user.email, subject: 'Surf Report - Fairhaven')
      # end
    end
end
