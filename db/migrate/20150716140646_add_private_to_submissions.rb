class AddPrivateToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :private, :boolean
  end
end
