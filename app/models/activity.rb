class Activity < ActiveRecord::Base
  attr_accessible :user_id, :contact_id, :post_requirement_id, :seeked_shared, :order_id
  belongs_to :user
  belongs_to :order
end
