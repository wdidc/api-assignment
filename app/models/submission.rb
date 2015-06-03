class Submission < ActiveRecord::Base
  belongs_to :criterium, dependent: :destroy
end
