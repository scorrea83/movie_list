class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
      t.integer "movie_id"
      t.integer "list_id"
    end
  end
end
