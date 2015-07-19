require 'redcarpet'
module ApplicationHelper
  def repo_name url
    return url[(url.rindex("/") + 1)..-1] if url.include? "/"
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }
    if text.blank?
      nil
    else
      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)
      markdown.render(text).html_safe
    end
  end

  def student_url(student_json)
    github_id = student_json.fetch('github_user_id')
    URI::HTTP.build(host: 'students.wdidc.org', path: "/#{github_id}").to_s
  end
end
