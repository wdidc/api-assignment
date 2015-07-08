module ApplicationHelper

  def repo_name url
    return url[(url.rindex("/") + 1)..-1] if url.include? "/"
  end

  def student_url(student_json)
    github_id = student_json.fetch('github_user_id')
    URI::HTTP.build(host: 'students.wdidc.org', path: "/#{github_id}").to_s
  end
end
