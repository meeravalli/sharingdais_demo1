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
            #elsif params[:p_f_hide] == "4"
             # provider_ride_login
            #  redirect_to profile_home_path(current_user)
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
            redirect_to post_your_ad_login_sharing_index_path
          else
            redirect_to new_user_session_path       
          end
          
        end
      else   
      
        flash[:alert] = 'Invalid email or password'               
        if params[:p_f_hide] == "1" || params[:p_f_hide] == "2" || params[:p_f_hide] == "3" || params[:p_f_hide] == "4"
          redirect_to post_your_ad_login_sharing_index_path
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
=begin
def provider_ride_login
    @post_requirement = RiderPostRequirement.new(params[:rider_post_requirement])
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

=end  
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
