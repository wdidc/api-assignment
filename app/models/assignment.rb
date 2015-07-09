class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  after_create :seed_submissions
  def issues token, url=nil, isshs=[]
    begin
      if self.repo_url 
	url ||= "https://api.github.com/repos/" + self.repo_url.gsub(/https:\/\/github\.com\//,"") + "/issues?state=all&access_token="+token
	res = HTTParty.get(url)
	isshs << JSON.parse(res.body)
	isshs.flatten!(1)
	next_url = res.headers["link"].match(/<(.*)>; rel="next"/)
	if next_url[1]
	  self.issues(token, next_url[1], isshs)
	end
	@issues = {}
	isshs.each do |issue|
	  @issues[issue["user"]["login"]] = {
	    url: issue["html_url"],
	    comments: issue["body"]
	  }
	end
      else
	@issues = {}
      end
    rescue
      @issues = {}
    end
    @issues
  end
  private
  def seed_submissions
    students = Student.all
    students.each do |student|
      if student["name"]
	self.submissions.create( github_id: student["github_user_id"] )
      end
    end
  end
end
