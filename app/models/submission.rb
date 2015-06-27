class Submission < ActiveRecord::Base
  belongs_to :assignment
  def student
    res = JSON.parse(HTTParty.get("http://api.wdidc.org/students/#{self.github_id}").body)
    if res.class == Hash
      return res
    else
      return {name:""}
    end
  end
  def as_json(options={})
    super.as_json(options).merge({assignment_title: self.assignment.title})
  end
end
