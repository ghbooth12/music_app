class AddGeolocationToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :latitude, :float
    add_column :concerts, :longitude, :float
  end
end
