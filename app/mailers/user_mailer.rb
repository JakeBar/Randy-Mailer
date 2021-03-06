class UserMailer < ApplicationMailer
  default from: 'notifications@randy.com'

  def surf_report(user, email)
    result = get_surf_data

    return result if result.nil?

    # store applicable data
    @login =  user
    @email =  email
    @surf_data = filter_surf_results(result)
    @swell_score = get_surf_score(@surf_data)

    # given that the swell score is greater than x, send email
    mail(to: email, subject: 'Surf Report - Maroochydore Beach') if @swell_score >= 2
  end

  # get_surf_data() - get the surf data from MagicSeaweed API
  def get_surf_data
    url = "http://magicseaweed.com/api/#{ENV['MAGIC_SEAWEED_API_KEY']}/forecast/?spot_id=6128&units=UK"
    uri = URI(url)

    response = Net::HTTP.get(uri)
    ActiveSupport::JSON.decode(response) if response != ''
  end

  # filter_surf_results(surf_data) - filter out results outside the next 24 hours
  def filter_surf_results(surf_data)
    current_time = Time.now.to_i
    data = []

    surf_data.each do |item|
      # if the report time has already passed,
      # OR
      # it's more than 24 hours later than local time
      # remove from the stack
      if (item['localTimestamp'] >= (current_time - 90)) && (item['localTimestamp'] <= (current_time + 60 * 60 * 15))
        data.push(item)
      end
    end
    data
  end

  # evaluate_surf_score(surf_data) - return the average swell score
  def get_surf_score(surf_data)
    swell_values = []
    surf_data.each do |item|
      swell_values.push(item['solidRating'])
    end
    (swell_values.sum / swell_values.size.to_f).round
  end
end
