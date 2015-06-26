class Devise::OmniauthCallbacksController < DeviseController
  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  def passthru
    render status: 404, text: "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  def create
   post_id = request.env['omniauth.params']['post_id']
   book_post = request.env['omniauth.params']['book_post_id']
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
        if !post_id.nil?
           user_food_intersted_without_login_facebook(post_id,@user.id) 
         elsif !book_post.nil?
          user_book_intersted_without_login_facebook(book_post,@user.id) 
        end
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "omniauth") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  


# def user_food_intersted_without_login_facebook(post_id,user_id)
# @post_requirement = PostRequirement.find(post_id)
# user = User.find(user_id)
# food_type = FoodType.find(@post_requirement.food_type_id).name
#  location = Location.find(@post_requirement.location_id).location_name
#  if user_id != @post_requirement.user_id
#     @negotiate = Negotiate.create(:post_requirement_id => @post_requirement.id, :user_id => user_id, :nego_id => @post_requirement.user_id).valid?
#     if @negotiate
#       message = Message.create(:subject => "New Order", :content => "You have received a new order from #{user.name}. Please confirm the order", :user_id => user_id, :posted_to => @post_requirement.user_id, :post_requirement_id => @post_requirement.id,:food => food_type, :location => location, :read => false, :order_status => true)
#       provider = User.find(@post_requirement.user_id)
#       seeker = user
#         UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
#       contact_details = User.find(@post_requirement.user_id)
#       UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
#     end
#     flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    
#   else
#   flash[:alert] = "you cannot negotiate"
#   end
# end
# def user_book_intersted_without_login_facebook(post_id, user_id)
#   @post_requirement = BookPostRequirement.find(post_id)
#   user = User.find(user_id)
# if user.id != @post_requirement.user_id
#     @negotiate = BookNegotiate.create(:book_post_requirement_id => @post_requirement.id, :user_id => user_id, :nego_id => @post_requirement.user_id).valid?

#     if @negotiate
#       message = BookMessage.create(:subject => "New Order", :content => "You have received a new order from #{user.name}. Please confirm the order", :user_id => user_id, :posted_to => @post_requirement.user_id, :book_post_requirement_id => @post_requirement.id, :location_id => location, :read => false, :order_status => true)
#       provider = User.find(@post_requirement.user_id)
#       seeker = user
#       #UserMailer.new_book_order_for_provider(provider,message.id, seeker).deliver
      
#       contact_details = User.find(@post_requirement.user_id)
#       #UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
#     end
#     flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
#     #render :json => @negotiate.to_json
#   else
#   flash[:alert] = "you cannot negotiate"
#   end
# end







  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
end
