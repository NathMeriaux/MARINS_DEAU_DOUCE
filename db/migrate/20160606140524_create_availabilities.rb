class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :start_date
      t.date :end_date
      t.references :boat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
