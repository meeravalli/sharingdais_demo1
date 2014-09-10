class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_session
  before_filter :common_details
  
  def get_locations
    @locations = City.find(params[:id]).locations
    render :json => @locations.to_json
  end

  def check_session
    if current_user
      session[:unread_messages] = Message.find_all_by_posted_to_and_read_and_trashed(current_user.id, false, false).count
    end
  end

  def common_details
    @locations =    []
    @regions = Region.find(:all, :order => "id DESC")
    @services = Service.find(:all, :order => "service_type DESC")
    @providers = Provider.find(:all, :order => "provider_type ASC")
    @cities = City.find(:all, :order => "city_name ASC")
    @food_types = FoodType.find(:all, :order => "id DESC")
    @meal_types = MealType.find(:all, :order => "id DESC")
    session[:city_id] = nil
    session[:any] = nil
    session[:bulk] = nil
    session[:any1] = nil
  end
  
    def after_sign_in_path_for(resource)
      if current_user.admin?
       return '/admins'
      elsif !current_user.admin?
      return session["user_return_to"] || root_path
      else
        return '/users/sign_in'
      end    
    end
  #The below code is for Trending locations. Kindly do not delete below method.
  
  def get_trending_locations
    if params[:service_type] == "1"
      food_providers = form_json_data(0,params[:city_id])
      food_seekers = form_json_data(1,params[:city_id])
      render :json => {:providers_loc => food_providers, :seekers_loc => food_seekers}.to_json
    else
      book_providers = book_form_json_data(0,params[:city_id])
      book_seekers = book_form_json_data(1,params[:city_id])
      render :json => {:providers_loc => book_providers, :seekers_loc => book_seekers}.to_json
    end
  end

  def form_json_data(seeker_provider,city_id)
    location_ids = PostRequirement.where("city_id = ? AND seeker_provider = ?",city_id,seeker_provider).group("location_id").count.sort_by {|k,v| v}.reverse[0,5]
    trending_locations = Hash.new {|h,k| h[k] = {} }
    trending_locations_array = []
    location_ids.each do |val|
      loc = Location.where("id = ?",val[0]).last 
      trending_locations[val[1]].merge!({loc.id => loc.location_name})   
    end 
    trending_locations.values.each do |val|
      val.sort_by {|_key, value| value}.each do |sval| 
        trending_locations_array.push(sval)  
      end 
    end
    trending_locations_array.push([params[:city_id],"city_id"])
  end

  def book_form_json_data(seeker_provider,city_id)
    location_ids = BookPostRequirement.where("city_id = ? AND seeker_provider = ?",city_id,seeker_provider).group("location_id").count.sort_by {|k,v| v}.reverse[0,5]
    trending_locations = Hash.new {|h,k| h[k] = {} }
    trending_locations_array = []
    location_ids.each do |val|
      loc = Location.where("id = ?",val[0]).last 
      trending_locations[val[1]].merge!({loc.id => loc.location_name})   
    end 
    trending_locations.values.each do |val|
      val.sort_by {|_key, value| value}.each do |sval| 
        trending_locations_array.push(sval)  
      end 
    end
    trending_locations_array.push([params[:city_id],"city_id"])
  end
  
end