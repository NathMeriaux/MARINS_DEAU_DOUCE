class AddCoordinatesToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :latitude, :float
    add_column :boats, :longitude, :float
  end
end
