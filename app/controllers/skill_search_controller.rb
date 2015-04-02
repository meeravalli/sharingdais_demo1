class SkillSearchController < ApplicationController
  layout 'skill_search'
  def index
    #puts "======================#{params[:search][:skill_type_id]}================="
    @search_params = nil
    if params[:search]
      session[:city_id] = params[:search][:city_id]
      location = params[:search][:location_id]
      key = params[:search][:skill_type_id]
      @city = City.where(:id => params[:search][:city_id]).first
      @location = Location.where(:id => params[:search][:location_id]).first
      city = params[:search][:city_id]
      query = ""
      if params[:search][:skill] == "0"
        query += "seeker_provider = 0"
      else
        query += "seeker_provider = 1"
      end
      if params[:search][:skill_type_id] != '1'
        if key.present?
            query += " and sub_category_id = #{key}"
        end
      end
     if params[:search].has_key?("include_near_by_locations")
        location = Location.where("id = ?",params[:search][:location_id]).last
        city = City.where("id = ?",params[:search][:city_id]).last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = SkillPostRequirement.near("#{search_area}", 10).where(query)
        @search_results = SkillPostRequirement.where(query)
      end
      #@search_results = SkillPostRequirement.where(query).paginate(:page => params[:page], :per_page => 25)
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
     elsif params[:city].present?
       key = params[:key]
       query = ""
      if params[:skill] == "0"
        query += "seeker_provider = 0"
      else
        query += "seeker_provider = 1"
      end
      if params[:key] != '1'
        if key.present?
            query += " and sub_category_id = #{key}"
        end
      end
        l = Location.where(:location_name => params[:location]).first
        c = City.where(:city_name => params[:city]).first
        location = Location.where("id = ?","#{l.id}").last
        city = City.where("id = ?","#{c.id}").last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = SkillPostRequirement.near("#{search_area}", 10).where(query).paginate(:page => params[:page], :per_page => 15)
        @search_params = @search_results.count
        @locations = params[:city].blank? ? [] : city.locations
        @page = params[:params] || 1 
        
    end
        redirect_to "/#{@city.city_name}/#{@location.location_name}/skill_search?key=#{params[:search][:skill_type_id]}&skill=#{params[:search][:skill]}" unless @city.nil?
       
  end

  def skill_result
    if params[:seeker_provider] == 'true'
      @prm = true
    else
      @prm = false
    end
    @search_results = SkillPostRequirement.where("location_id=? and seeker_provider=?",params[:id],@prm).paginate(:page => params[:page], :per_page => 5)
    puts "====#{@search_results}==================================================="
  end
end
