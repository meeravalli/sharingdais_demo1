class BookSearchController < ApplicationController
  def index
	@search_params = nil
    if params[:search]
      session[:city_id] = params[:search][:city_id]
      key = params[:search][:key].downcase
      location = params[:search][:location_id]
      book = params[:search][:book]
      city = params[:search][:city_id]

      query = ""
      if params[:search][:book] == "0"
      	query += "seeker_provider = 0"
      else
      	query += "seeker_provider = 1"
      end

      if key.present?
      	query += ' and (lower(name) LIKE "%' + key + '%" or lower(isbn_number) LIKE "%' + key + '%" or lower(author) LIKE "%' + key + '%")'
      end

      if city.present?
      	  query += " and city_id = #{city}"
      end

      if location.present?
      	  query += " and location_id = #{location}"
      end
      @search_results = BookPostRequirement.where(query).paginate(:page => params[:page], :per_page => 25)

      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
    end
  end
end
