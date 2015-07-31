class Submission < ActiveRecord::Base
  belongs_to :assignment

  def students
    Student.all
  end

  def issue(token)
    url ||= "https://api.github.com/repos/" + self.assignment.repo_url.gsub(/https:\/\/github\.com\//,"") + "/issues?state=all&access_token=" + token
    res = HTTParty.get(url)
    return JSON.parse(res.body).first
  end

  def student
    return Student.find(self.github_id)
  end

  def as_json(options={})
    super.as_json(options).merge({
      assignment_title: assignment_title,
      assignment_type: assignment_type,
      assignment_repo_url: assignment_repo_url,
      student_name: student.name
    })
  end

  def assignment_title
    self.assignment && self.assignment.title
  end

  def assignment_repo_url
    self.assignment && self.assignment.repo_url
  end

  def assignment_type
    self.assignment && self.assignment.assignment_type
  end

  def involves_squad
    studs = students.select{|each_student|
      each_student.squad === self.student.squad
    }
    query = []
    studs.each{|student|
      query.push("involves%3A#{student.github_username}")
    }
    return query.join("+")
  end

end
