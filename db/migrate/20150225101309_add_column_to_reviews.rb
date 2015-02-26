class AddColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :book_post_requirement_id, :integer
    add_column :reviews, :skill_post_requirement_id, :integer
    add_column :reviews, :post_requirement_id, :integer
  end
end
