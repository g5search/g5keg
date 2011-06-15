class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
  acts_as_rateable
  
  # Sets logo upload parameters
  has_attached_file :logo_path, :styles => { :medium => "190x270" }
  
  def rating_for_user(user)
    if rating=rated_by?(user)
      rating.rate.score
    else
      0
    end
  end
  
  #Sets logo path for display in view
  def beer_logo_path
    unless self.logo_path.url(:medium) == "/logo_paths/medium/missing.png"
      self.logo_path.url(:medium)
    else
      "/images/beers/blank.png"
    end
  end
  
end
