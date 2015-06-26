class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.integer :city_id

      t.timestamps
    end
  end
end
