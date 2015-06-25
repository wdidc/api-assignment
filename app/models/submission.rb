class Submission < ActiveRecord::Base
  belongs_to :assignment, dependent: :destroy
end
