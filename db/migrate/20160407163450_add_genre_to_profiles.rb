class AddGenreToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :genre_id, :integer
    add_index :profiles, :genre_id
  end
end
