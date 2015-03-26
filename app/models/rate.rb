class Rate < ActiveRecord::Base
  belongs_to :negotiate
  belongs_to :book_negotiate
  belongs_to :peer_negotiate
  belongs_to :user
  belongs_to :post_requirement
  belongs_to :book_post_requirement
  belongs_to :skill_post_requirement
  belongs_to :peer_service_post_requirement
  attr_accessible :negotiate_id, :book_negotiate_id, :book_post_requirement_id,:skill_post_requirement_id, :post_requirement_id, :user_id, :rated_id, :rated_no, :service_type, :peer_service_post_requirement_id, :peer_negotiate_id
end
