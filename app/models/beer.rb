class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
  acts_as_rateable
  def rating_for_user(user)
    if rating=rated_by?(user)
      rating.rate.score
    else
      0
    end
  end
end
