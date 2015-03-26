class CreatePeerActivities < ActiveRecord::Migration
  def change
    create_table :peer_activities do |t|
      t.integer :peer_service_post_requirement_id
      t.integer :contact_id
      t.integer :peer_order_id
      t.integer :user_id
      t.boolean :seeked_shared

      t.timestamps
    end
  end
end
