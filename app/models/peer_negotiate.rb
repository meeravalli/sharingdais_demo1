class PeerNegotiate < ActiveRecord::Base
  attr_accessible :nego_id, :peer_service_post_requirement_id, :user_id
  belongs_to :user
  belongs_to :peer_service_post_requirement
  has_many :rates
  has_many :reviews
  validates_uniqueness_of :peer_service_post_requirement_id, :scope => :user_id
end
