class CreateVenues < ActiveRecord::Migration[7.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :price_per_day
      t.string :location
      t.integer :size_of_band
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
