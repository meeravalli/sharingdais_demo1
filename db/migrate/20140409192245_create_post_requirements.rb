class CreatePostRequirements < ActiveRecord::Migration
  def change
    create_table :post_requirements do |t|
      t.integer :service_id
      t.integer :provider_id
      t.integer :city_id
      t.integer :location_id
      t.integer :food_type_id
      t.integer :meal_type_id
      t.integer :region_id
      t.integer :no_of_persons
      t.decimal :budget
      t.text :details
      t.integer :user_id
      t.boolean :seeker_provider, :default => true
      t.timestamps
    end
  end
end
