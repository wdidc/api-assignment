class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :assignment_type
      t.string :weekday
      t.string :due_date
      t.string :repo_url
      t.string :rubric_url
      t.timestamps null: false
    end
  end
end
