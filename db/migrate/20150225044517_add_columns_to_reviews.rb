class AddColumnsToReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :negotiate_id, :integer
    add_column :reviews, :book_negotiate_id, :integer
  end
end
