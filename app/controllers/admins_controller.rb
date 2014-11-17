class AdminsController < ApplicationController
  
before_filter :ensure_admin


	def index
    @users = User.where(:admin => false).order("created_at DESC").paginate(:page => params[:page])
	end

  def post_requirements
    @food_orders = PostRequirement.where("seeker_provider=?",1).order("created_at DESC").paginate(:page => params[:page])
    @book_orders = BookPostRequirement.where("seeker_provider=?",1).order("created_at DESC").paginate(:page => params[:page])
    @skill_orders = SkillPostRequirement.where("seeker_provider=?",1).order("created_at DESC").paginate(:page => params[:page])
  end
  def list_requirements
    @food_orders = PostRequirement.where("seeker_provider=?",0).order("created_at DESC").paginate(:page => params[:page])
    @book_orders = BookPostRequirement.where("seeker_provider=?",0).order("created_at DESC").paginate(:page => params[:page])
    @skill_orders = SkillPostRequirement.where("seeker_provider=?",0).order("created_at DESC").paginate(:page => params[:page])
  end

  def user_orders
    #@order_food=Order.where("skill_post_requirement_id IS ?",nil).order("order_date DESC").paginate(:page => params[:page])
    @order_food=Negotiate.where("post_requirement_id IS NOT NULL AND skill_post_requirement_id IS NULL").order("created_at DESC").paginate(:page => params[:page])
    #@order_book=BookOrder.where("order_date=?",Date.today).order("created_at DESC").paginate(:page => params[:page])
    @order_book=BookNegotiate.where("book_post_requirement_id IS NOT NULL").order("created_at DESC").paginate(:page => params[:page])
    @order_skill=Negotiate.where("post_requirement_id IS NULL AND skill_post_requirement_id IS NOT NULL").order("created_at DESC").paginate(:page => params[:page])
  end

  def exl
    @users = User.where(:admin => false).order("created_at DESC")
    respond_to do |format|
      format.xls #{ send_data @users.to_csv(col_sep: "\t") }
    end
  end
	
	def block_unblock
    user = User.find(params[:id])
    if user.status?
      User.update(user.id, {:status => false})
      flash[:notice] = "You have blocked #{user.name}" 
    else
      User.update(user.id, {:status => true})
      flash[:notice] = "You have unblocked #{user.name}"
    end
    redirect_to admins_path
  end
  
    def view_user_profile_activity
    @user = User.find(params[:id])
    @post_requirements = @user.post_requirements
    @activities = @user.activities
    @activities_food = @activities.where("post_requirement_id IS NOT NULL")
    @activities_skill = @activities.where("skill_post_requirement_id IS NOT NULL")
    @book_post_requirements = @user.book_post_requirements
    @book_activities = @user.book_activities
    @skill_post_requirements = @user.skill_post_requirements
   end
	
	def destroy_user
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "#{user.name} successfully deleted"
    redirect_to admins_path
  end
  
  def activate_user
    user = User.find(params[:id])
    user.confirm!
    flash[:notice] = "#{user.name} successfully activated"
    redirect_to admins_path
  end
  
  def edit_user_profile
    @user=User.where("id=?",params[:user_id])
    if !params[:name].blank? 
      @user.first.name=params[:name] 
    end
    if !params[:address].blank?
      @user.first.address=params[:address]
    end
    if !params[:phone_no].blank?
      @user.first.phone_no=params[:phone_no]
    end
    @user.first.save(:validate => false)
    flash[:notice] = "#{@user.first.name} profile updated successfully"
    @user = User.find(params[:user_id])
  end

  def edit_food_post
    @post=PostRequirement.where("id=?",params[:id]).first  
    if !params[:budget].blank?
      @post.budget= params[:budget] 
    end
    if !params[:details].blank?
      @post.details= params[:details]
    end
    if !params[:post_requirement].blank?
      @post.attributes = params[:post_requirement] 
    end
    @post.save
    #render :json => {:status => "Post Requirement updated successfully"}
    respond_to do |format|
      format.js #{ send_data @users.to_csv(col_sep: "\t") }
    end
  end
  def destroy_food_post
    user = PostRequirement.find(params[:id])
    user.destroy
    flash[:notice] = "Post successfully deleted"
    if params[:seeker_provider] = '0'
      redirect_to list_requirements_path
    else
      redirect_to post_requirements_path
    end
  end
  def edit_book_post
    @post=BookPostRequirement.where("id=?",params[:id]).first
    puts "#{params[:book_post_requirement]}==========================="
    if !params[:budget].blank?
      @post.rent= params[:budget] 
    end
    if !params[:details].blank?
      @post.description= params[:details]
    end
    if !params[:book_post_requirement].blank?
      @post.attributes = params[:book_post_requirement] 
    end
    @post.save
    #render :json => {:status => "Post Requirement updated successfully"}
    respond_to do |format|
      format.js
    end
  end
  def destroy_book_post
    user = BookPostRequirement.find(params[:id])
    user.destroy
    flash[:notice] = "Post successfully deleted"
    if params[:seeker_provider] = '0'
      redirect_to list_requirements_path
    else
      redirect_to post_requirements_path
    end
  end

  def edit_skill_post
    @post=SkillPostRequirement.where("id=?",params[:id])
    if !params[:budget].blank?
      @post.first.charges= params[:budget] 
    end
    if !params[:details].blank?
      @post.first.description= params[:details]
    end
    if !params[:skill_post_requirement].blank?
      @post.first.attributes = params[:skill_post_requirement] 
    end
    @post.first.save
    #render :json => {:status => "Post Requirement updated successfully"}
    respond_to do |format|
      format.js
    end
  end
  def destroy_skill_post
    user = SkillPostRequirement.find(params[:id])
    user.destroy
    flash[:notice] = "Post successfully deleted"
    if params[:seeker_provider] = '0'
      redirect_to list_requirements_path
    else
      redirect_to post_requirements_path
    end
  end

  def user_add_clicks
    @counter=Ad.all
  end

  private

def ensure_admin
 unless current_user && current_user.admin?
   render :text => "You are not authorised to perform this action", :status => :unauthorized
 end
end
 
end
