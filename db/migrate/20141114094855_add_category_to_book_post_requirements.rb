class AddCategoryToBookPostRequirements < ActiveRecord::Migration
  def change
    add_column :book_post_requirements, :category_id, :integer
  end
end
