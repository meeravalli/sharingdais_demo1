class AddPeerColumnsToPeerServicePostRequirements < ActiveRecord::Migration
  def change
    add_column :peer_service_post_requirements, :peer, :binary
  end
end
