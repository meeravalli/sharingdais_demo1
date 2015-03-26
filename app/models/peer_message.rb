class PeerMessage < ActiveRecord::Base
  attr_accessible :accepted, :content, :location_id, :order_status, :peer_order_id, :peer_service_post_requirement_id, :posted_to, :read, :subject, :trashed, :user_id
 belongs_to :user
 belongs_to :location
end
