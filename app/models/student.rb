class Student
  def self.all
    HTTParty.get("http://api.wdidc.org/students")
  end
end
