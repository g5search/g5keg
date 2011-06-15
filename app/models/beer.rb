class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
  acts_as_rateable
  
  # Sets logo upload parameters
  has_attached_file :logo_path, 
    :styles => { :medium => "190x270" }, 
    :default_url => "/images/beers/blank.png",
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  
  def rating_for_user(user)
    if rating=rated_by?(user)
      rating.rate.score
    else
      0
    end
  end
  
  #Sets logo path for display in view
  def beer_logo_path
    self.logo_path.url(:medium)
  end
  
end
