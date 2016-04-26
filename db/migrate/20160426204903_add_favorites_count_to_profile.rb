class AddFavoritesCountToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :favorites_count, :integer, default: 0
  end
end
