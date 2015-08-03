class Student
  @@students = HTTParty.get("http://api.wdidc.org/students")

  def self.all
    @@students.map do |student_info|
      Student.new(student_info)
    end
  end

  def self.find(gh_user_id)
    student_info = @@students.find{|s| s["github_user_id"] == gh_user_id.to_i }
    Student.new(student_info) if student_info
  end

  def initialize(student_info)
    # is it likely that student_info is a hash of student info
    github_user_id = student_info["github_user_id"]
    fail ArgumentError, "student_info is required (#{student_info})." if github_user_id.nil?
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
