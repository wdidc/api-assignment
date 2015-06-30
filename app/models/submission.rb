class Submission < ActiveRecord::Base
  belongs_to :assignment
  @@students = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)

  def students
    @@students
  end

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

  def involves_squad
    studs = @@students.select{|s|
      s["squad"] === student["squad"]
    }
    query = []
    studs.each{|s|
      query.push("involves%3A#{s["github_username"]}")
    }
    return query.join("+")
  end

end
