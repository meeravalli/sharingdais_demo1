class BookOrder < ActiveRecord::Base
  attr_accessible :book_post_requirement_id, :order_date, :provider_id, :user_id
  has_one :book_order_cancel, :dependent => :destroy
  has_many :book_activities, :dependent => :destroy
  belongs_to :user
  belongs_to :book_post_requirement
end
