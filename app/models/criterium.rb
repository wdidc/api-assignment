class Criterium < ActiveRecord::Base
  belongs_to :assignment, dependent: :destroy
  has_many :submissions
end
