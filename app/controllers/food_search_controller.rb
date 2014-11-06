class FoodSearchController < ApplicationController
include ActionView::Helpers::NumberHelper
layout 'food_search'
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
      @search_results = PostRequirement.filter_conditions(params[:search])#.paginate(:page => params[:page], :per_page => 25)
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
    end
  end

  def food_result
    if params[:seeker_provider] == 'true'
      @prm = true
    else
      @prm = false
    end
    @search_results = PostRequirement.where("location_id=? AND seeker_provider=?",params[:id],@prm)
  end
end
