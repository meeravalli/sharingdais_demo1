class BookOrderCancel < ActiveRecord::Base
  attr_accessible :book_order_id, :cancel_date
  belongs_to :book_order
end
