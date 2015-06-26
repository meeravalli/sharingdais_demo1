class Negotiate < ActiveRecord::Base
  attr_accessible :post_requirement_id, :skill_post_requirement_id, :user_id, :nego_id
  belongs_to :user
  belongs_to :post_requirement
  belongs_to :skill_post_requirement 
  has_many :rates
  has_many :reviews
  
  #validates_uniqueness_of :post_requirement_id,:skill_post_requirement_id, :scope => :user_id

#Public Methods


def self.user_negotiate_interst(post_id,user)
	post_req = PostRequirement.find(post_id)
	food_type = FoodType.find(post_req.food_type_id).name
	 location = Location.find(post_req.location_id).location_name
	if user.id != post_req.user_id
	    negotiate = Negotiate.create(:post_requirement_id => post_id, :user_id => user.id, :nego_id => post_req.user_id).valid?
	    if negotiate
	      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{user.name}. Please confirm the order", :user_id => user.id, :posted_to => post_req.user_id, :post_requirement_id => post_id,:food => food_type, :location => location, :read => false, :order_status => true)
	      provider = User.find(post_req.user_id)
	      seeker = user
	      #UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
	      #UserMailer.mail_contact_info_provider(provider,provider,seeker).deliver
	    end
	    output = true
	else
	   output = false
	end
  return output

end
def self.user_skill_negotiate_interst(post_id,user)
	post_req = SkillPostRequirement.find(post_id)
	
	 location = Location.find(post_req.location_id).location_name
	if user.id != post_req.user_id
	    negotiate = Negotiate.create(:skill_post_requirement_id => post_id, :user_id => user.id, :nego_id => post_req.user_id).valid?
	    if negotiate
	      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{user.name}. Please confirm the order", :user_id => user.id, :posted_to => post_req.user_id, :skill_post_requirement_id => post_id, :location => location, :read => false, :order_status => true)
	      provider = User.find(post_req.user_id)
	      seeker = user
	      #UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
	      #UserMailer.mail_contact_info_provider(provider,provider,seeker).deliver
	    end
	    output = true
	else
	   output = false
	end
  return output

end


end
