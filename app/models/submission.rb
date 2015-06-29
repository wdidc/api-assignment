class Submission < ActiveRecord::Base
  belongs_to :assignment
  @@students = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)
  def student
    @@students.each do |student|
      if student["github_user_id"] == self.github_id
	return student
      end
    end
  end
  def as_json(options={})
    super.as_json(options).merge({assignment_title: self.assignment.title})
  end
end
