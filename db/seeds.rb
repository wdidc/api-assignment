# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Assignment.destroy_all
Assignment.create([
  {title: "HTML Resume", weekday: "", due_date: "",
    repo_url: "https://github.com/ga-dc/html_resume",
    rubric_url: "",
    assignment_type: "homework"},
  {title: "Fellowship", weekday: "", due_date: "",
    repo_url: "https://github.com/ga-dc/fellowship",
    rubric_url: "",
    assignment_type: "homework"},
    {title: "Project 1", weekday: "w03d01", due_date: "07/08/2015",
      repo_url: "https://github.com/ga-dc/pbj-project1",
      rubric_url: "",
      assignment_type: "project"}
  ])

Submission.destroy_all
Assignment.all.each do |assignment|
  assignment.submissions.create([
    {github_id: 8145721, html_url: "benjr.example.com", repo_url: "benjr.github.com", status: "complete"},
    {github_id: 8145721, html_url: "njr.example.com", repo_url: "benjr.github.com", status: ""},
    {github_id: 8145721, html_url: "njr.example.com", repo_url: "benjr.github.com", status: ""},
    {github_id: 7883907, html_url: "parke.example.com", repo_url: "parke.github.com", status: ""}
  ])
end
