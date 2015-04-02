class FoodSearchController < ApplicationController
include ActionView::Helpers::NumberHelper
layout 'food_search'
   def index
    @search_params = nil
    @city = nil
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
      @city = City.where(:id => params[:search][:city_id]).first
      @food_type = FoodType.where(:id => params[:search][:food_type_id]).first
      @location = Location.where(:id => params[:search][:location_id]).first
      @search_results = PostRequirement.filter_conditions(params[:search])
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
    elsif params[:city].present?
      city = City.where(:city_name => params[:city]).first
      location = Location.where(:location_name => params[:location]).first
      @search_results = PostRequirement.filter_conditions_food(params[:city],params[:location],params[:key],params[:t]).paginate(:page => params[:page], :per_page => 15)
      @search_params = @search_results.count
      @locations = params[:city].blank? ? [] : city.locations
      @page = params[:page] || 1 


    end
    redirect_to "/#{@city.city_name}/#{@location.location_name}/food_search?key=#{@food_type.name}&t=#{params[:search][:food]}" unless @city.nil?
    
  end

  def food_result
    if params[:seeker_provider] == 'true'
      @prm = true
    else
      @prm = false
    end
    @search_results = PostRequirement.where("location_id=? AND seeker_provider=?",params[:id],@prm).paginate(:page => params[:page], :per_page => 5)
  end
end
