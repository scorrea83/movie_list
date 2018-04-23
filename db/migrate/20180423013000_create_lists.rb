class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string "title"
      t.string "description"
      t.integer "user_id"
    end
  end
end
