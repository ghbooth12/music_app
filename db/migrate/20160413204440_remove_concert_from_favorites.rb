class RemoveConcertFromFavorites < ActiveRecord::Migration
  def change
    remove_index :favorites, :concert_id
    remove_column :favorites, :concert_id, :integer
  end
end
