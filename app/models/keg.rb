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

  # We are assuming keg weight is 11 kg (for now)
  # Based on rigorous testing (emmm...consumption) we have determined
  # that a pint is approximately 0.45 kg.
  def remaining_pints
    ((current_weight-11)/0.45).to_i
  end

  # There are 124 pints in a keg (according to the Googs)
  def remaining_percent
    (remaining_pints.to_f)/(124.to_f)
  end
end
