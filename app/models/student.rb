class Student
  @@students = HTTParty.get("http://api.wdidc.org/students")

  def self.all
    @@students
  end
end
