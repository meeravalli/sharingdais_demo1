class PeerNegotiate < ActiveRecord::Base
  attr_accessible :nego_id, :peer_service_post_requirement_id, :user_id
  belongs_to :user
  belongs_to :peer_service_post_requirement
  has_many :rates
  has_many :reviews
  #validates_uniqueness_of :peer_service_post_requirement_id, :scope => :user_id

def self.user_negotiate_interst(post_id,user)
	post_req = PeerServicePostRequirement.find(post_id)
	#food_type = FoodType.find(post_req.food_type_id).name
	
	 location = Location.find(post_req.location_id).location_name
	if user.id != post_req.user_id
	    negotiate = PeerNegotiate.create(:peer_service_post_requirement_id => post_id, :user_id => user.id, :nego_id => post_req.user_id).valid?
	    if negotiate
	      message = PeerMessage.create(:subject => "New Order", :content => "You have received a new order from #{user.name}. Please confirm the order", :user_id => user.id, :posted_to => post_req.user_id, :peer_service_post_requirement_id => post_id, :location_id => location, :read => false, :order_status => true)
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