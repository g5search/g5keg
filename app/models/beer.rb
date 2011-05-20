class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :kegs
  validates_presence_of :name, :brewery
end
