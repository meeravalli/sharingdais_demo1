class BookActivity < ActiveRecord::Base
  attr_accessible :book_post_requirement_id, :contact_id, :book_order_id, :seeked_shared, :user_id
  belongs_to :user
  belongs_to :book_order
  belongs_to :book_post_requirement
end
