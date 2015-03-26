class CreatePeerMessages < ActiveRecord::Migration
  def change
    create_table :peer_messages do |t|
      t.boolean :accepted
      t.integer :user_id
      t.integer :posted_to
      t.text :content
      t.boolean :read
      t.string :subject
      t.integer :peer_service_post_requirement_id
      t.integer :peer_order_id
      t.integer :location_id
      t.boolean :trashed
      t.boolean :order_status

      t.timestamps
    end
  end
end
