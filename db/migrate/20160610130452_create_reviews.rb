class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :boat, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
