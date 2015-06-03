class Assignment < ActiveRecord::Base
  has_many :criteria
  has_many :submissions, through: :criteria
end
