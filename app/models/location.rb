class Location < ActiveRecord::Base
  attr_accessible :city_id, :location_name
  belongs_to :city
  has_many :book_messages
  has_many :peer_messages
end
