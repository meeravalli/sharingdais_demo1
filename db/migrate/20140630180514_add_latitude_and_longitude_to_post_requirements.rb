class AddLatitudeAndLongitudeToPostRequirements < ActiveRecord::Migration
  def change
    add_column :post_requirements, :latitude, :float, after: :region_id
    add_column :post_requirements, :longitude, :float, after: :latitude
  end
end
