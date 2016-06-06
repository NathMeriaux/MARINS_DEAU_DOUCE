class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :name
      t.string :location
      t.integer :capacity
      t.string :boat_picture
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
