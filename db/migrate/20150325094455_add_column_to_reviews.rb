class AddColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :peer_service_post_requirement_id, :integer
    add_column :reviews, :peer_negotiate_id, :integer
  end
end
