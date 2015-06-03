# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Assignment.create([
  {title: "Project 1", weekday: "w03d01", due_date: "w03d05", repo_url: "www.some_repo_url.com", rubric_url: "some_rubric_url"},
  {title: "Project 2", weekday: "w06d01", due_date: "w06d05", repo_url: "www.another_repo_url.com", rubric_url: "another_rubric_url"}
  ])

Assignment.all.each do |assignment|
  assignment.criteria.create([
    {title: "user stories", body: "create 3 user stories"},
    {title: "ERD's", body: "create erds"}
    ])
end

Submission.create([
  {github_id: 12642, criterium_id: Criterium.all[0].id, html_url: "www.htmlrus.com", repo_url: "www.reposrus.com", status: "completed"},
  {github_id: 22642, criterium_id: Criterium.all[1].id, html_url: "www.htmlrus.com", repo_url: "www.reposrus1.com", status: "completed"},
  {github_id: 42642, criterium_id: Criterium.all[3].id, html_url: "www.htmlrus.com", repo_url: "www.reposrus2.com", status: "completed"},
  {github_id: 12342, criterium_id: Criterium.all[3].id, html_url: "www.htmlrus.com", repo_url: "www.reposrus3.com", status: "completed"},
  {github_id: 12542, criterium_id: Criterium.all[2].id, html_url: "www.htmlrus.com", repo_url: "www.reposrus4.com", status: "completed"}
  ])
