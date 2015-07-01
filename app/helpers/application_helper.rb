module ApplicationHelper

  def repo_name url
    return url[(url.rindex("/") + 1)..-1]
  end
end
