
class PeerServicesController < ApplicationController
layout 'peer_service'
  def index
    
   @search_params = nil
   if params[:search]
     ci = Location.where(:id => params[:search][:location_id]).first
     session[:city_id] = ci.city.id
     location = params[:search][:location_id]
     key = params[:search][:peer_category_id]
     city = ci.city.id
     @city = City.find(ci.city.id)
     params[:search][:city_id] = ci.city.id
     query = ""
      if params[:search][:peer] == "0"
       query += "seeker_provider = 0"
      else
       query += "seeker_provider = 1"
      end
      if params[:search][:peer_category_id] != '1'
        if key.present?
            query += " and peer_category_id = #{key}"
        end
      end
     
      if params[:search].has_key?("include_near_by_locations")
        location = Location.where("id = ?",params[:search][:location_id]).last
        city = City.where("id = ?",params[:search][:city_id]).last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = PeerServicePostRequirement.near("#{search_area}", 10).where(query).paginate(:page => params[:page], :per_page => 15)    
      else
        @search_results = PeerServicePostRequirement.where(query).paginate(:page => params[:page], :per_page => 15)
      end 
      #@search_results = SkillPostRequirement.where(query).paginate(:page => params[:page], :per_page => 25)
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
      @page = params[:page] || 1

    elsif  params[:city].present?
      ci = City.where(:city_name => params[:city]).first
      loc = Location.where(:location_name => params[:location]).first
     session[:city_id] = ci.id
     location = loc.id
     key = params[:key]
     city = ci.id
     # params[:search][:city_id] = ci.id
     # params[:search][:location_id] = loc.id
     query = ""
      if params[:peer] == "0"
       query += "seeker_provider = 0"
      else
       query += "seeker_provider = 1"
      end
      if key != '1'
        if key.present?
            query += " and peer_category_id = #{key}"
        end
      end
     
      #if params[:search].has_key?("include_near_by_locations")
        location = Location.where("id = ?",loc.id).last
        city = City.where("id = ?",city).last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = PeerServicePostRequirement.near("#{search_area}", 10).where(query).paginate(:page => params[:page], :per_page => 15)    
      #else
        #@search_results = PeerServicePostRequirement.where(query).paginate(:page => params[:page], :per_page => 15)
      #end 
      #@search_results = SkillPostRequirement.where(query).paginate(:page => params[:page], :per_page => 25)
      @search_params = @search_results.count
      @locations = params[:city].blank? ? [] : ci.locations
      @page = params[:page] || 1
  
      end
    redirect_to "/#{city.city_name}/#{location.location_name}/peer_services?key=#{params[:search][:peer_category_id]}&peer=#{params[:search][:peer]}" unless @city.nil?
  end

  def peer_result
    if params[:seeker_provider] == 'true'
      @prm = true
    else
      @prm = false
    end
    @search_results = PeerServicePostRequirement.where("location_id=? and seeker_provider=?",params[:id],@prm).paginate(:page => params[:page], :per_page => 15)
    puts "====#{@search_results}==================================================="
  end

  
end

