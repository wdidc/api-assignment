class Submission < ActiveRecord::Base
  belongs_to :assignment
  @@students = JSON.parse(HTTParty.get("http://api.wdidc.org/students").body)

  def students
    @@students
  end

  def student
    return @@students.find{|s| s["github_user_id"] == self.github_id }
  end

  def as_json(options={})
    super.as_json(options).merge({
      assignment_title: assignment_title, 
      assignment_type: assignment_type,
      student_name: student["name"]
    })
  end

  def assignment_title
    self.assignment && self.assignment.title
  end

  def assignment_type
    self.assignment && self.assignment.assignment_type
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
