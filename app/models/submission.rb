class Submission < ActiveRecord::Base
  belongs_to :assignment, dependent: :destroy
  def student
    res = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{self.github_id}").body)
    if res.class == Hash
      return res
    else
      return {name:""}
    end
  end
end
