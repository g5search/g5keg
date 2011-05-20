module WelcomeHelper
  def remaining_percent_of(keg)
    number_to_percentage(keg.remaining_percent*100, :precision => 0) rescue '0%'
  end

  def date_tapped(keg)
    keg.tapped.strftime('%m/%d/%y') rescue 'N/A'
  end

  def days_tapped(keg)
    distance_of_time_in_words(Date.today.to_time,@currently_on_tap.tapped.to_time) rescue '0'
  end

  def last_updated(keg)
    keg.updated_at rescue 'N/A'
  end
end
