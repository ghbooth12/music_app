class AddColumnsToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :title, :string
    add_column :concerts, :location_name, :string
  end
end
