class AddGenreToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :genre_id, :integer
    add_index :concerts, :genre_id
  end
end
