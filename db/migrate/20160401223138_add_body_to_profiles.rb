class AddBodyToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :body, :text
  end
end
