class ChangeConcertsTime < ActiveRecord::Migration
  def change
    rename_column :concerts, :time, :show_date 
  end
end
