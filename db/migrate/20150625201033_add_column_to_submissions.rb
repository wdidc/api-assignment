class AddColumnToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :assignment_id, :integer
  end
end
