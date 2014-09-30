class Negotiate < ActiveRecord::Base
  attr_accessible :post_requirement_id, :user_id, :nego_id
  belongs_to :user
  belongs_to :post_requirement
  has_many :rates
  validates_uniqueness_of :post_requirement_id, :scope => :user_id
end
