class Issue
  # TODO: compare implementation v. student.rb
  attr_reader :user_id, :url, :comments, :state, :created_at, :updated_at, :closed_at

  def initialize(issue_info)
    return nil unless (issue_info && issue_info.is_a?(Hash) && issue_info.fetch("user", false) )
    @info = issue_info

    @user_id = issue_info["user"]["id"]
    @url = issue_info["html_url"]
    @comments = issue_info["body"]
    @state = issue_info["state"]

    @created_at = parse_time(issue_info["created_at"])
    @updated_at = parse_time(issue_info["updated_at"])
    @closed_at = parse_time(issue_info["closed_at"])
  end

  private
  def parse_time(time)
    return nil unless time
    DateTime.parse(time).advance(hours: -4)
  end
end
