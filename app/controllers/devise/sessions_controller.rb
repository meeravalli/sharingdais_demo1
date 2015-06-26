class Devise::SessionsController < DeviseController
  prepend_before_filter :require_no_authentication, only: [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, only: :create
  prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create     
      if !params[:user][:email].blank?
        email = params[:user][:email]
        user123 = User.find_by_email(email)
        if !user123.nil?
          if user123.status.eql? true
          self.resource = warden.authenticate!(auth_options) 
          set_flash_message(:notice, :signed_in) if is_flashing_format?          
          sign_in(resource_name, resource)
          yield resource if block_given?
            if params[:p_f_hide] == "1"
              provider_food_login
              redirect_to profile_home_path(current_user)
            elsif params[:p_f_hide] == "2"
              provider_book_login
              redirect_to profile_home_path(current_user)
            elsif params[:p_f_hide] == "3"
              provider_skill_login
              redirect_to profile_home_path(current_user)
            elsif params[:p_f_hide] == "4"
              provider_peer_login
              redirect_to profile_home_path(current_user)
            elsif params[:food_intersted].present?
              user_food_intersted_without_login(params[:food_intersted])
              #redirect_to profile_home_path(current_user)
              redirect_to "/food_search"
            elsif params[:book_intersted].present?
              user_book_intersted_without_login(params[:book_intersted])
              #redirect_to profile_home_path(current_user)
              redirect_to "/book_search"
            elsif params[:skill_intersted].present?
              user_skill_intersted_without_login(params[:skill_intersted])
              #redirect_to profile_home_path(current_user)
              redirect_to "/skill_search"
            elsif params[:peer_intersted].present?
              user_peer_intersted_without_login(params[:peer_intersted])
              #redirect_to profile_home_path(current_user)
              redirect_to "/peer_services"

            else
              respond_with resource, location: after_sign_in_path_for(resource) 
            end         
          else
            flash[:alert] =  'Your account is blocked. Please contact admin'
            redirect_to new_user_session_path            
          end
        else 
                
          flash[:alert] = 'Invalid email or password'          
          if params[:p_f_hide] == "1" || params[:p_f_hide] == "2" || params[:p_f_hide] == "3" || params[:p_f_hide] == "4"
            redirect_to share_with_us_sharing_index_path
          else
            redirect_to new_user_session_path       
          end
          
        end
      else   
      
        flash[:alert] = 'Invalid email or password'               
        if params[:p_f_hide] == "1" || params[:p_f_hide] == "2" || params[:p_f_hide] == "3" || params[:p_f_hide] == "4"
          redirect_to share_with_us_sharing_index_path
        else
          redirect_to new_user_session_path       
        end 

      end    
  end
  

  # DELETE /resource/sign_out
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield resource if block_given?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end

# Save Ads method
def provider_food_login
  @post_requirement = PostRequirement.new(params[:post_requirement])
    if request.post?
      if params[:any]
        @post_requirement.no_of_persons = params[:any]
        session[:any] = params[:any]
      end
      if @post_requirement.valid?
        @post_requirement.user_id = current_user.id
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
      end
    end
end

#user without login food intersted
def user_food_intersted_without_login(post_id)
@post_requirement = PostRequirement.find(post_id)
food_type = FoodType.find(@post_requirement.food_type_id).name
 location = Location.find(@post_requirement.location_id).location_name
 if current_user.id != @post_requirement.user_id
    @negotiate = Negotiate.create(:post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?
    if @negotiate
      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :post_requirement_id => @post_requirement.id,:food => food_type, :location => location, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
        UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
      contact_details = User.find(@post_requirement.user_id)
      UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end
def user_book_intersted_without_login(post_id)
  @post_requirement = BookPostRequirement.find(post_id)
location = Location.find(@post_requirement.location_id).location_name
if current_user.id != @post_requirement.user_id
    @negotiate = BookNegotiate.create(:book_post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?

    if @negotiate
      message = BookMessage.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :book_post_requirement_id => @post_requirement.id, :location => location, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
      #UserMailer.new_book_order_for_provider(provider,message.id, seeker).deliver
      
      contact_details = User.find(@post_requirement_id.user_id)
      #UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end
def user_skill_intersted_without_login(post_id)
@post_requirement = SkillPostRequirement.find(post_id)
 location = Location.find(@post_requirement.location_id).location_name
 if current_user.id != @post_requirement.user_id
    @negotiate = Negotiate.create(:skill_post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?
    if @negotiate
      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :skill_post_requirement_id => @post_requirement.id, :location => location, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
        UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
      contact_details = User.find(@post_requirement.user_id)
      UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end
def user_food_intersted_without_login(post_id)
@post_requirement = PostRequirement.find(post_id)
food_type = FoodType.find(@post_requirement.food_type_id).name
 location = Location.find(@post_requirement.location_id).location_name
 if current_user.id != @post_requirement.user_id
    @negotiate = Negotiate.create(:post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?
    if @negotiate
      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :post_requirement_id => @post_requirement.id,:food => food_type, :location => location, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
        UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
      contact_details = User.find(@post_requirement.user_id)
      UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end
def user_book_intersted_without_login(post_id)
  @post_requirement = BookPostRequirement.find(post_id)
if current_user.id != @post_requirement.user_id
    @negotiate = BookNegotiate.create(:book_post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?

    if @negotiate
      message = BookMessage.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :book_post_requirement_id => @post_requirement.id, :location_id => @post_requirement.location_id, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
      #UserMailer.new_book_order_for_provider(provider,message.id, seeker).deliver
      
      contact_details = User.find(@post_requirement.user_id)
      #UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end
def user_peer_intersted_without_login(post_id)
@post_requirement = PeerServicePostRequirement.find(post_id)
 if current_user.id != @post_requirement.user_id
    @negotiate = PeerNegotiate.create(:peer_service_post_requirement_id => @post_requirement.id, :user_id => current_user.id, :nego_id => @post_requirement.user_id).valid?
    if @negotiate
      message = PeerMessage.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => @post_requirement.user_id, :peer_service_post_requirement_id => @post_requirement.id, :location_id => @post_requirement.location_id, :read => false, :order_status => true)
      provider = User.find(@post_requirement.user_id)
      seeker = current_user
        #UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
      contact_details = User.find(@post_requirement.user_id)
      #UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    flash[:notice] = "Thank you for interest , Your contact details will be shared and if you want more services make search here.."
    #render :json => @negotiate.to_json
  else
  flash[:alert] = "you cannot negotiate"
  end
end

def provider_book_login
  @post_requirement = BookPostRequirement.new(params[:book_post_requirement])
    if request.post?
      if @post_requirement.valid?
        @post_requirement.user_id = current_user.id        
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
        current_user
      end
    end
end
def provider_skill_login
    @post_requirement = SkillPostRequirement.new(params[:skill_post_requirement])
    if request.post?
      if @post_requirement.valid?
         @post_requirement.user_id = current_user.id 
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
      end
    end
  end

def provider_peer_login
    @post_requirement = PeerServicePostRequirement.new(params[:peer_service_post_requirement])
    if request.post?
      if @post_requirement.valid?
        @post_requirement.user_id = current_user.id        
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
      end
    end
  end

 
# End Save Ads




  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
