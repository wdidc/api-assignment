# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Assignment.destroy_all
Assignment.create([
  {title: "Wendy Bite", weekday: "w03d01", due_date: "w03d05", repo_url: "www.some_repo_url.com", rubric_url: "some_rubric_url", assignment_type: "homework"},
  {title: "Project 2", weekday: "w06d01", due_date: "w06d05", repo_url: "www.another_repo_url.com", rubric_url: "another_rubric_url", assignment_type: "project"}
  ])

Submission.destroy_all
Assignment.all.each do |assignment|
  assignment.submissions.create([
    {github_id: 8145721, html_url: "www.htmlrus.com", repo_url: "www.reposrus.com", status: "complete"},
    {github_id: 7883907, html_url: "www.htmlrus.com", repo_url: "www.reposrus1.com", status: "incomplete"}
  ])
end
