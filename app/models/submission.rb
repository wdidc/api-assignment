class Submission < ActiveRecord::Base
  belongs_to :assignment, dependent: :destroy
  def student
    JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{self.github_id}").body)
  end
end
