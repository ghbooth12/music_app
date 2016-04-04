class ChangeConcertsAttributes < ActiveRecord::Migration
  def change
    add_column :concerts, :show_time, :time
    change_column :concerts, :time, :date
  end
end
