class Order < ActiveRecord::Base
  attr_accessible :user_id, :order_date, :provider_id, :post_requirement_id
  has_one :order_cancel, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  belongs_to :user
  belongs_to :post_requirement
end
