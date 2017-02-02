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

      # get three applicable dates for the next 24 hours
      time = Time.now.to_i

      report_data = result
      iterator = 0

      report_data.each do |item|

        iterator += 1

        #if the report time is beyond one of the first 8 three hour intervals, remove it from the stack
        if (iterator > 8)
          report_data.pop
        end

        # if the report time has already passed, remove it from the stack
        if (item['localTimestamp'] <= time)
          report_data.shift
        end
        report_data.pop
      end

      data.surf_data = report_data

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
        mail(to: @user.email, subject: 'Surf Report - Randy')
      # end
    end
end
