class Provider < ActiveRecord::Base
  attr_accessible :provider_type
  has_many :orders, :dependent => :destroy
end
