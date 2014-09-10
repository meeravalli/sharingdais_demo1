class AdminsController < ApplicationController
  
before_filter :ensure_admin


	def index
    @users = User.where(:admin => false).order("created_at DESC").paginate(:page => params[:page])
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
  
  
  private

def ensure_admin
 unless current_user && current_user.admin?
   render :text => "You are not authorised to perform this action", :status => :unauthorized
 end
end
 
end
