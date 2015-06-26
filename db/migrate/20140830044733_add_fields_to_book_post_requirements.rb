class AddFieldsToBookPostRequirements < ActiveRecord::Migration
  def change
    add_column :book_post_requirements, :rent, :float
  end
end
