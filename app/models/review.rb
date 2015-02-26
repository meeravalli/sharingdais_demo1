class Review < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :post_requirement
  belongs_to :skill_post_requirement
  belongs_to :book_post_requirement
  belongs_to :negotiate
  belongs_to :book_negotiate

end
