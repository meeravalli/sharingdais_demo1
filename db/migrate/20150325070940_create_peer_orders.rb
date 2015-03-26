class CreatePeerOrders < ActiveRecord::Migration
  def change
    create_table :peer_orders do |t|
      t.integer :peer_service_post_requirement_id
      t.date :order_date
      t.integer :user_id
      t.integer :provider_id

      t.timestamps
    end
  end
end
