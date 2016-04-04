class ChangeZipcodeType < ActiveRecord::Migration
  def change
    change_column :concerts, :zipcode, :string
  end
end
