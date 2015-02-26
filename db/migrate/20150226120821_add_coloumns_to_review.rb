class AddColoumnsToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :negotiate_id, :integer
    add_column :reviews, :book_negotiate_id, :integer
    add_column :reviews, :book_post_requirement_id, :integer
    add_column :reviews, :post_requirement_id, :integer
    add_column :reviews, :skill_post_requirement_id, :integer
  end
end
