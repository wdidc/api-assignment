class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  after_create :seed_submissions

  def issues_for(submission, token)
    issues(token).select{ |issue| issue.user_id == submission.github_id }
  end

  def issues(token, url=nil, isshs=[])
    @issues ||= begin
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

        @issues = isshs.map{|i| Issue.new(i)}
      else
        @issues = {}
      end
    rescue Exception => e
      logger.warn(e)
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

  def summary_info
    summary_items = [assignment_type]
    summary_items << weekday if weekday?
    summary_items << "due: #{due_date}" if due_date?
    summary_items
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
