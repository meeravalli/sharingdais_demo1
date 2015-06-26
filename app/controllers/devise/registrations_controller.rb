class Devise::RegistrationsController < DeviseController
  prepend_before_filter :require_no_authentication, only: [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  # GET /resource/sign_up
  def new
    build_resource({})
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.skip_confirmation! if params[:user_inter_food] == '1'
    resource.skip_confirmation! if params[:user_inter_book] == '2'
    resource.skip_confirmation! if params[:user_inter_peer] == '3'
    resource.skip_confirmation! if params[:user_inter_skill] == '4'
      

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        set_flash_message :notice, :food_inter if is_flashing_format? and params[:user_inter_food] == '1'
        set_flash_message :notice, :book_inter if is_flashing_format? and params[:user_inter_book] == '2'
        set_flash_message :notice, :peer_inter if is_flashing_format? and params[:user_inter_peer] == '3'
        set_flash_message :notice, :skill_inter if is_flashing_format? and params[:user_inter_skill] == '4'
      if params[:user_inter_food] == '1'
        Negotiate.user_negotiate_interst(params[:food_inter],resource)
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      elsif  params[:user_inter_book] == '2'
        BookNegotiate.user_negotiate_interst(params[:book_inter],resource)
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      elsif  params[:user_inter_peer] == '3'
        PeerNegotiate.user_negotiate_interst(params[:peer_inter],resource)
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
         elsif  params[:user_inter_skill] == '4'
        Negotiate.user_negotiate_interst(params[:skill_inter],resource)
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
          
        else
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        if params[:p_f_hide] == '1'          
          provider_food_signup
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        elsif params[:p_f_hide] == '2'
          provider_book_signup    
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        elsif params[:p_f_hide] == '3' 
          provider_skill_signup
          respond_with resource, location: after_inactive_sign_up_path_for(resource) 
        elsif params[:p_f_hide] == '4' 
          provider_peer_signup
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
          else
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  # resistration with ads
  def provider_food_signup
    @post_requirement = PostRequirement.new(params[:post_requirement])
    if request.post?
      if params[:any]
        @post_requirement.no_of_persons = params[:any]
        session[:any] = params[:any]
      end
      if @post_requirement.valid?
        @post_requirement.user_id = resource.id
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Your post is submitted. Please confirm your account, the link sent to your email id"
        #redirect_to profile_home_path(current_user)
      end
    end
  end

def provider_book_signup
  @post_requirement = BookPostRequirement.new(params[:book_post_requirement])
  if request.post?
    if @post_requirement.valid?
      @post_requirement.user_id = resource.id        
      post_status = true
    else
      post_status = false
    end
    if @post_requirement.save && post_status
      flash[:notice] = "Your post is submitted. Please confirm your account, the link sent to your email id"
      #redirect_to profile_home_path(current_user)
    end
  end
end
def provider_skill_signup
  @post_requirement = SkillPostRequirement.new(params[:skill_post_requirement])
  if request.post?
    if @post_requirement.valid?
      @post_requirement.user_id = resource.id       
      post_status = true
    else
      post_status = false
    end
    if @post_requirement.save && post_status
      flash[:notice] = "Your post is submitted. Please confirm your account, the link sent to your email id"
      #redirect_to profile_home_path(current_user)
    end
  end
end

def provider_peer_signup
  @post_requirement = PeerServicePostRequirement.new(params[:peer_service_post_requirement])
  if request.post?
    if @post_requirement.valid?
      @post_requirement.user_id = resource.id       
      post_status = true
    else
      post_status = false
    end
    if @post_requirement.save && post_status
      flash[:notice] = "Your post is submitted. Please confirm your account, the link sent to your email id"
      #redirect_to profile_home_path(current_user)
    end
  end
end


  # End resistration with ads

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    respond_to?(:root_path) ? root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)

  end 
  def food_inter_path_for(resource)
      #redirect_to
       profile_home_path(resource)
    #signed_in_root_path(resource)
  end






  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
