class Submission < ActiveRecord::Base
  belongs_to :criterium, dependent: :destroy
  belongs_to :assignment, dependent: :destroy
end
