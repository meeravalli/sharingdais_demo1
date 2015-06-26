class Message < ActiveRecord::Base
  attr_accessible :content, :posted_to, :read, :user_id, :subject, :order_status, :accepted, :post_requirement_id, :skill_post_requirement_id, :food, :location, :order_id
  belongs_to :user
  belongs_to :skill_post_requirement

end
