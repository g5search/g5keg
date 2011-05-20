class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
  acts_as_rateable
end
