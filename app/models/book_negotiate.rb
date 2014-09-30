class BookNegotiate < ActiveRecord::Base
  attr_accessible :book_post_requirement_id, :user_id, :nego_id
  belongs_to :user
  belongs_to :book_post_requirement
  has_many :rates
  validates_uniqueness_of :book_post_requirement_id, :scope => :user_id
end
