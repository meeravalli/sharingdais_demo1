class PeerOrder < ActiveRecord::Base
  attr_accessible :order_date, :peer_service_post_requirement_id, :provider_id, :user_id
 has_one :peer_order_cancel, :dependent => :destroy
 has_many :peer_activities, :dependent => :destroy
 belongs_to :user
 belongs_to :peer_service_post_requirement
end
