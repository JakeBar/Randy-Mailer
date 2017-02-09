class UserMailer < ApplicationMailer
    default from:'notifications@randy.com'

    def surf_report(user, email)

      result = get_surf_data()

      # store applicable data
      data = User.new
      data.login =  user
      data.email =  email
      data.surf_data = filter_surf_results(result)
      data.swell_score = get_surf_score(data.surf_data)
      @user = data
      @url  = 'http://randy.com/login'

      # given that the swell score is greater than x, send email
      # if (data.swell_score > 2)
        mail(to: @user.email, subject: 'Surf Report - Fairhaven')
      # end
    end

  # get_surf_data() - get the surf data from MagicSeaweed API
  def get_surf_data()
    url = 'http://magicseaweed.com/api/1/forecast/?spot_id=1070'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return ActiveSupport::JSON.decode(response)
  end

  # filter_surf_results(surf_data) - filter out results outside the next 24 hours
  def filter_surf_results(surf_data)
    current_time = Time.now.to_i
    data = Array.new

    surf_data.each do |item|
      # if the report time has already passed,
      # OR
      # it's more than 24 hours later than local time
      # remove from the stack
      if (item['localTimestamp'] >= (current_time + 60 * 60 * 9) ) && (item['localTimestamp'] <= (current_time + 60 * 60 * 24))
        data.push(item)
      end
    end
    return data
  end

  # evaluate_surf_score(surf_data) - return the average swell score
  def get_surf_score(surf_data)
    swell_values = Array.new
    surf_data.each do |item|
      swell_values.push(item['solidRating'])
    end
    return (swell_values.sum / swell_values.size.to_f).round
  end
end
