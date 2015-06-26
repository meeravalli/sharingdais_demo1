class BookMessage < ActiveRecord::Base
  attr_accessible :accepted, :book_order_id, :book_post_requirement_id, :content, :location_id, :order_status, :posted_to, :read, :subject, :trashed, :user_id
  belongs_to :user
  belongs_to :location
end
