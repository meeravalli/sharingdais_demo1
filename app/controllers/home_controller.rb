class HomeController < ApplicationController
include ActionView::Helpers::NumberHelper
before_filter :authenticate_user!, :except => [:index]
  def index
    @search_params = nil
    if params[:search]
      if params[:search][:food].eql?("2")
        remove_params = [:meal_type_id, :region_id]
        params[:search][:no_of_persons] = params[:search][:no_of_guests]
        session[:bulk] =  params[:search][:food]
      else
        remove_params = [:identity, :no_of_guests]
      end
      remove_params.each { |k| params[:search].delete k }
      session[:city_id] = params[:search][:city_id]      
      session[:any] = params[:search][:any]
      session[:any1] = params[:search][:any1]
      @search_results = PostRequirement.filter_conditions(params[:search])
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
    end
  end

  def profile
    @user = current_user
    @post_requirements = @user.post_requirements
    @book_post_requirements = @user.book_post_requirements
    @book_activities = @user.book_activities.order( 'id DESC' )
    @activities = @user.activities.order( 'id DESC' )
    # Order Trace
    @negotiatn=Negotiate.where("user_id=? OR nego_id=?",@user,@user).order( 'id DESC' )
    @negotiatn_book=BookNegotiate.where("user_id=? OR nego_id=?",@user,@user).order( 'id DESC' )
  end
  
  def edit_profile
    @user = User.find(params[:id])
  end
  
  def update_profile
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
     flash[:notice] = 'Successfully updated'
     redirect_to profile_home_path(@user)
     else
     render "edit_profile"
    end
  end
  
  def rate_me    
    @find_user=Rate.where("user_id=? AND negotiate_id=? AND service_type=?",params[:user_id],params[:negotiate_id],"Food Sharing")
    if !@find_user.empty?     
      render :json => {:status => "You have already rated this item"}
    else
      @rating=Rate.new(:post_requirement_id => params[:post_requirement_id],:negotiate_id => params[:negotiate_id], :user_id =>params[:user_id], :rated_id =>params[:rated_id], :rated_no =>params[:rate_no],:service_type =>"Food Sharing" )
      @rating.save!
      render :json => {:status => "Thank you for rating"}
    end
    #puts "user_id:#{params[:user_id]}=====rated_id:#{params[:rated_id]}=====rate_no:#{params[:rate_no]}========negotiate_id:#{params[:negotiate_id]}"
  end

  def rate_me_book
    @find_user=Rate.where("user_id=? AND book_negotiate_id=? AND service_type=?",params[:user_id],params[:book_negotiate_id],"Book Sharing")
    if !@find_user.empty?     
      render :json => {:status => "You have already rated this item"}
    else
      @rating=Rate.new(:book_post_requirement_id => params[:book_post_requirement_id],:book_negotiate_id => params[:book_negotiate_id], :user_id =>params[:user_id], :rated_id =>params[:rated_id], :rated_no =>params[:rate_no],:service_type =>"Book Sharing" )
      @rating.save!
      render :json => {:status => "Thank you for rating"}
    end
  end

  def destroy_order
    order=Negotiate.find(params[:id])
    order.destroy
    render :json => {:status => "ok"}
  end
  def destroy_book_order
    order=BookNegotiate.find(params[:id])
    order.destroy
    render :json => {:status => "ok"}
  end


end
