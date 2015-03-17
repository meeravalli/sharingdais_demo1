class SharingController < ApplicationController
  #before_filter :authenticate_user!
  #prepend_before_filter :require_no_authentication, only: [ :post_your_ad, :post_requirement, :list_availability ]
  def shares_with_us
    post_requirement
    list_availability
  end
  
  def post_requirement
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
        redirect_to profile_home_path(current_user)
      end
    end
  end

  def list_availability
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
        redirect_to profile_home_path(current_user)
      end
    end
  end
  
  def post_book_requirement
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
        redirect_to profile_home_path(current_user)
      end
    end
  end

  def post_skill_requirement
    @post_requirement = SkillPostRequirement.new(params[:post_skill_requirement])
    puts "#{params[:post_skill_requirement]}===================================="
    if request.post?
      if @post_requirement.valid?
        @post_requirement.user_id = current_user.id        
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
        redirect_to profile_home_path(current_user)
      end
    end
  end
=begin 
  def post_rider_requirement
    @post_requirement = RiderPostRequirement.new(params[:post_rider_requirement])
    puts "#{params[:post_rider_requirement]}===================================="
    if request.post?
      if @post_requirement.valid?
        @post_requirement.user_id = current_user.id        
        post_status = true
      else
        post_status = false
      end
      if @post_requirement.save && post_status
        flash[:notice] = "Successfully posted"
        redirect_to profile_home_path(current_user)
      end
    end
  end
=end
  def book_list_availability
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
        redirect_to profile_home_path(current_user)
      end
    end
  end

  def skill_list_availability
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
        redirect_to profile_home_path(current_user)
      end
    end
  end
=begin  
  def rider_list_availability
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
        redirect_to profile_home_path(current_user)
      end
    end
  end
=end  
  def edit_post_requirement
    @post_requirement = PostRequirement.find(params[:id])
    city = City.find(@post_requirement.city_id)
    @locations = city.locations
  end

  def edit_book_post_requirement
    @book_post_requirement = BookPostRequirement.find(params[:id])
    city = City.find(@book_post_requirement.city_id)
    @locations = city.locations
  end

  def edit_skill_post_requirement
    @skill_post_requirement = SkillPostRequirement.find(params[:id])
    city = City.find(@skill_post_requirement.city_id)
    @locations = city.locations
  end
=begin  
  def edit_rider_post_requirement
    @rider_post_requirement = RiderPostRequirement.find(params[:id])
    city = City.find(@rider_post_requirement.city_id)
    @locations = city.locations
  end
=end  
  def update_post_requirement
    @post_requirement = PostRequirement.find(params[:id])
      if params[:any]
        session[:any] = params[:any]
        if @post_requirement.update_attributes(params[:post_requirement], :no_of_persons => params[:any], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_post_requirement"
        end
      else
        if @post_requirement.update_attributes(params[:post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_post_requirement"
        end
      end
  end
  
  def update_book_post_requirement
    @post_requirement = BookPostRequirement.find(params[:id])
        if @post_requirement.update_attributes(params[:book_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_book_post_requirement"
        end
  end
  def update_skill_post_requirement
    @post_requirement = SkillPostRequirement.find(params[:id])
        if @post_requirement.update_attributes(params[:skill_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_skill_post_requirement"
        end
  end
=begin  
  def update_rider_post_requirement
    @post_requirement = RiderPostRequirement.find(params[:id])
        if @post_requirement.update_attributes(params[:Rider_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_rider_post_requirement"
        end
  end
=end
  def edit_list_availability
    @post_requirement = PostRequirement.find(params[:id])
    city = City.find(@post_requirement.city_id)
    @locations = city.locations
  end

  def edit_book_list_availability
    @book_post_requirement = BookPostRequirement.find(params[:id])
    city = City.find(@book_post_requirement.city_id)
    @locations = city.locations
  end
  def edit_skill_list_availability
    @skill_post_requirement = SkillPostRequirement.find(params[:id])
    city = City.find(@skill_post_requirement.city_id)
    @locations = city.locations
  end 
=begin 
  def edit_rider_list_availability
    @rider_post_requirement = RiderPostRequirement.find(params[:id])
    city = City.find(@rider_post_requirement.city_id)
    @locations = city.locations
  end
=end 
  def update_list_availability
      @post_requirement = PostRequirement.find(params[:id])
      if params[:any]
        session[:any] = params[:any]
        if @post_requirement.update_attributes(params[:post_requirement], :no_of_persons => params[:any], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else 
        render "edit_list_availability"
        end
      else
        if @post_requirement.update_attributes(params[:post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_list_availability"
        end
      end
    end
    
    def update_book_list_availability
      @book_post_requirement = BookPostRequirement.find(params[:id])
        if @book_post_requirement.update_attributes(params[:book_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_book_list_availability"
        end
    end
    def update_skill_list_availability
      @skill_post_requirement = SkillPostRequirement.find(params[:id])
        if @skill_post_requirement.update_attributes(params[:skill_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_skill_list_availability"
        end
    end
=begin   
    def update_rider_list_availability
      @rider_post_requirement = RiderPostRequirement.find(params[:id])
        if @rider_post_requirement.update_attributes(params[:rider_post_requirement], :user_id => current_user.id)
        flash[:notice] = 'Successfully updated'
        redirect_to profile_home_path(current_user)
        else
        render "edit_rider_list_availability"
        end
    end
=end
    def destroy_requirement
      post_requirement = PostRequirement.find(params[:id])
      user = User.find(post_requirement.user_id)
      post_requirement.destroy
      flash[:notice] = "Successfully destroyed."
      redirect_to profile_home_path(user)
   end

   def book_destroy_requirement
      book_post_requirement = BookPostRequirement.find(params[:id])
      user = User.find(book_post_requirement.user_id)
      book_post_requirement.destroy
      flash[:notice] = "Successfully destroyed."
      redirect_to profile_home_path(user)
   end
   def skill_destroy_requirement
      skill_post_requirement = SkillPostRequirement.find(params[:id])
      user = User.find(skill_post_requirement.user_id)
      skill_post_requirement.destroy
      flash[:notice] = "Successfully destroyed."
      redirect_to profile_home_path(user)
   end
=begin 
     def rider_destroy_requirement
      rider_post_requirement = RiderPostRequirement.find(params[:id])
      user = User.find(rider_post_requirement.user_id)
      rider_post_requirement.destroy
      flash[:notice] = "Successfully destroyed."
      redirect_to profile_home_path(user)
   end
=end 
  
  
end

