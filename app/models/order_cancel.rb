class OrderCancel < ActiveRecord::Base
  attr_accessible :cancel_date, :order_id
  belongs_to :order
end
