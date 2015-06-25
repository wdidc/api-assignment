class AddColumnToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :type, :string
  end
end
