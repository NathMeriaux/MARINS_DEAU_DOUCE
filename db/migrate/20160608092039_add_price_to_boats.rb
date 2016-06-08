class AddPriceToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :price, :integer
  end
end
