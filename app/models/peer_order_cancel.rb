class PeerOrderCancel < ActiveRecord::Base
  attr_accessible :cancel_date, :peer_order_id
  belongs_to :peer_order
end
