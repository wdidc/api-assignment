class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :criteria
      t.integer :github_id
      t.string :html_url
      t.string :repo_url
      t.string :status
      t.timestamps null: false
    end
  end
end
