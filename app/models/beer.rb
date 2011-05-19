class Beer < ActiveRecord::Base
  belongs_to :brewery
  scope :on_tap, where(:on_tap => true)
  validates :on_tap, :uniqueness => true, :if => :on_tap?

  def self.currently_on_tap
    on_tap.first
  end

  def self.currently_tapped?
    on_tap.count == 1
  end

  def tap
    self.on_tap = true
    save
  end

  def un_tap
    update_attribute(:on_tap, false)
  end

  def self.rotate_keg(new_beer)
    currently_on_tap.un_tap if self.currently_tapped?
    new_beer.tap
  end
end
