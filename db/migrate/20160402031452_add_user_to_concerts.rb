class AddUserToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :user_id, :integer
    add_index :concerts, :user_id
  end
end
