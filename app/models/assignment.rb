class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  after_create :seed_submissions
  private
  def seed_submissions
    students = Student.all
    students.each do |student|
      if student["name"]
	self.submissions.create( github_id: student["github_user_id"] )
      end
    end
  end
end
