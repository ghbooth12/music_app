class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :facebook_url
      t.string :twitter_url
      t.string :youtube_url
      t.string :soundcloud_url

      t.timestamps null: false
    end
  end
end
