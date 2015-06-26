class CreateBookPostRequirements < ActiveRecord::Migration
  def change
    create_table :book_post_requirements do |t|
      t.integer :service_id
      t.integer :city_id
      t.integer :location_id
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :name
      t.string :author
      t.integer :user_id
      t.boolean :seeker_provider
      t.string :isbn_number
      t.date :date_of_posting

      t.timestamps
    end
  end
end
