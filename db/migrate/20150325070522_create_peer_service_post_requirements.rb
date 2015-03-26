class CreatePeerServicePostRequirements < ActiveRecord::Migration
  def change
    create_table :peer_service_post_requirements do |t|
      t.integer :service_id
      t.integer :city_id
      t.integer :location_id
      t.integer :peer_category_id
      t.integer :user_id
      t.float :charges
      t.boolean :sun
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :sat
      t.float :latitude
      t.float :longitude
      t.boolean :seeker_provider
      t.text :speciality
      t.string :degree
      t.string :exp
      t.text :additinal_info
      t.text :review
      t.datetime :peer_updated_at
      t.integer :peer_file_size
      t.string :peer_content_type
      t.string :peer_file_name

      t.timestamps
    end
  end
end
