class AddColumnsToRates < ActiveRecord::Migration
  def change
    add_column :rates, :peer_service_post_requirement_id, :integer
    add_column :rates, :peer_negotiate_id, :integer
  end
end
