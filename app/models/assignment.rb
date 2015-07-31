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
      if res.headers["link"]
        next_url = res.headers["link"].match(/<(.*)>; rel="next"/)
        if next_url[1]
          self.issues(token, next_url[1], isshs)
        end
      end
        @issues = {}
        isshs.each do |issue|
          id = issue["user"]["id"]
          @issues[id] = {
            url: issue["html_url"],
            comments: issue["body"],
            state: issue["state"]
          }
          ["created", "updated", "closed"].each do |which|
            if issue["#{which}_at"]
              @issues[id][which] = DateTime.parse(issue["#{which}_at"]).advance(hours: -4)
            end
          end
        end
      else
        @issues = {}
      end
    rescue
      @issues = {}
    end
    @issues
  end

  def completion_count
    self.submissions.where(status: "complete").size
  end

  def completion_rate
    (100 * (self.completion_count.to_f / self.submissions.size)).round(0)
  end

  private
  def seed_submissions    
    Student.all.each do |student|
      if student.name
        self.submissions.create( github_id: student.github_user_id )
      end
    end
  end
end
