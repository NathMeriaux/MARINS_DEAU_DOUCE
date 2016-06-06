class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.string :status
      t.integer :review_rating
      t.text :review_content
      t.references :user, index: true, foreign_key: true
      t.references :boat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
