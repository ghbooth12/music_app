class AddFavoritesCountToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :favorites_count, :integer, default: 0

    # Profile.reset_column_information
    # Profile.all.each do |profile|
    #   profile.favorites_count = profile.favorites.count
    #   profile.save!
    # end
  end
end
