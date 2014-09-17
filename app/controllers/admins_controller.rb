class AdminsController < ApplicationController
  
before_filter :ensure_admin


	def index
    @users = User.where(:admin => false).order("created_at DESC").paginate(:page => params[:page])
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
    @book_post_requirements = @user.book_post_requirements
    @book_activities = @user.book_activities
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

  private

def ensure_admin
 unless current_user && current_user.admin?
   render :text => "You are not authorised to perform this action", :status => :unauthorized
 end
end
 
end
