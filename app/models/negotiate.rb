class Negotiate < ActiveRecord::Base
  attr_accessible :post_requirement_id, :user_id  
  belongs_to :user
  validates_uniqueness_of :post_requirement_id, :scope => :user_id
end
