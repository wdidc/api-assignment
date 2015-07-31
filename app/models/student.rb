class Student
  @@students = HTTParty.get("http://api.wdidc.org/students")

  def self.all
    @@students.map do |student_info|
      Student.new(student_info)
    end
  end

  def self.find(gh_user_id)
    student_info = @@students.find{|s| s["github_user_id"] == gh_user_id }
    Student.new(student_info)
  end

  def initialize(student_info)
    @info = student_info
  end

  def github_user_id
    @info["github_user_id"]
  end

  def github_username
    @info["github_username"]
  end

  def last_name
    self.name.split(" ").last
  end

  def name
    @info["name"]
  end

  def squad
    @info["squad"]
  end

  def submissions
    Submission.where(github_id: self.github_user_id)
  end
end
