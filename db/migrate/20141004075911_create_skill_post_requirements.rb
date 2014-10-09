class CreateSkillPostRequirements < ActiveRecord::Migration
  def change
    create_table :skill_post_requirements do |t|
      t.references :service
      t.references :city
      t.references :location
      t.references :sub_category
      t.references :user
      t.boolean :seeker_provider
      t.float :latitude
      t.float :longitude
      t.text :description
      t.boolean :home_service
      t.text :service_in_one_line
      t.float :charges
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun

      t.timestamps
    end
    add_index :skill_post_requirements, :service_id
    add_index :skill_post_requirements, :city_id
    add_index :skill_post_requirements, :location_id
    add_index :skill_post_requirements, :sub_category_id
    add_index :skill_post_requirements, :user_id
  end
end
