# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Assignment.destroy_all
Assignment.create([
  {title: "HTML Resume", weekday: "", due_date: "", repo_url: "https://github.com/ga-dc/html_resume", rubric_url: "", assignment_type: "homework"},
  {title: "Fellowship", weekday: "", due_date: "", repo_url: "https://github.com/ga-dc/fellowship", rubric_url: "", assignment_type: "homework"}
  ])

Submission.destroy_all
Assignment.all.each do |assignment|
  assignment.submissions.create([
    {github_id: 8145721, html_url: "www.htmlrus.com", repo_url: "www.reposrus.com", status: "complete"},
    {github_id: 7883907, html_url: "www.htmlrus.com", repo_url: "www.reposrus1.com", status: "incomplete"}
  ])
end
