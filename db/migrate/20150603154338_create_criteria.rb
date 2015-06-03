class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.belongs_to :assignment
      t.string :title
      t.string :body
      t.timestamps null: false
    end
  end
end
