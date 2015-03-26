class CreatePeerNegotiates < ActiveRecord::Migration
  def change
    create_table :peer_negotiates do |t|
      t.integer :peer_service_post_requirement_id
      t.integer :user_id
      t.integer :nego_id

      t.timestamps
    end
  end
end
