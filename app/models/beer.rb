class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
  acts_as_rateable
  
  # Sets logo upload parameters
  has_attached_file :logo_path, 
    :styles => { :medium => "190x270!" }, 
    :default_url => "/images/beers/blank.png",
    :storage => :s3,
    :bucket => 'g5kegapp',
    :path => "beers/:id/:style/:basename.:extension",
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }
  
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
