class Keg < ActiveRecord::Base
  belongs_to :beer
  scope :on_tap, where('tapped is not null and kicked is null')
  def self.rotate(new_keg)
    if old_keg=self.on_tap.first
      old_keg.update_attribute(:kicked, Date.today)
    end
    new_keg.update_attribute(:tapped, Date.today)
  end
end
