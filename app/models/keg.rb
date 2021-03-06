class Keg < ActiveRecord::Base
  belongs_to :beer
  scope :on_tap, where('tapped is not null and kicked is null')
  before_create :assign_weight
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

  def assign_weight
    self.current_weight = 67 unless self.current_weight?
  end

  # We are assuming keg weight is 14 kg (for now)
  # Based on rigorous testing (emmm...consumption) we have determined
  # that a pint is approximately 0.45 kg.
  
  def remaining_pints
    ((current_weight-14.25)/0.45).to_i > 0 ? ((current_weight-14.25)/0.45).to_i : 0
  end

  # There are 124 pints in a keg (according to the Googs)
  def remaining_percent
    (remaining_pints.to_f)/(124.to_f)
  end
end
