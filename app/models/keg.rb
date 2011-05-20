class Keg < ActiveRecord::Base
  belongs_to :beer
  scope :on_tap, where('tapped is not null and kicked is null')
  validates_presence_of :beer
  delegate :name, :description, :ibus, :alcohol, :logo_path, :to => :beer

  def self.current
    on_tap.first
  end

  def self.rotate(new_keg)
    if old_keg=current
      old_keg.update_attribute(:kicked, Date.today)
    end
    new_keg.update_attribute(:tapped, Date.today)
  end
end
