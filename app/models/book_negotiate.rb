class BookNegotiate < ActiveRecord::Base
  attr_accessible :book_post_requirement_id, :user_id
  belongs_to :user
  validates_uniqueness_of :book_post_requirement_id, :scope => :user_id
end
