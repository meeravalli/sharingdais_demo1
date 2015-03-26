class CreatePeerOrderCancels < ActiveRecord::Migration
  def change
    create_table :peer_order_cancels do |t|
      t.integer :peer_order_id
      t.date :cancel_date

      t.timestamps
    end
  end
end
