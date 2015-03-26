class PeerActivity < ActiveRecord::Base
  attr_accessible :contact_id, :peer_order_id, :peer_service_post_requirement_id, :seeked_shared, :user_id
 belongs_to :user
 belongs_to :peer_order
 belongs_to :peer_service_post_requirement
end
