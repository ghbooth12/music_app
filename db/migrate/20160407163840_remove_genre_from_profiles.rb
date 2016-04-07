class RemoveGenreFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :genre, :string
  end
end
