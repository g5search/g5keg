module WelcomeHelper
  def remaining_percent_of(keg)
    number_to_percentage(keg.remaining_percent*100, :precision => 0) rescue '0%'
  end

  def date_tapped(keg)
    keg.tapped.strftime('%m/%d/%y') rescue 'N/A'
  end

  def days_tapped(keg)
    distance_of_time_in_words(Time.now,@currently_on_tap.created_at) rescue '0'
  end

  def last_updated(keg)
    (keg.updated_at-8.hours).strftime('%m/%d/%y at %l:%M:%S %p') rescue 'N/A'
  end
end
