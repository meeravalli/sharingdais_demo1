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
  # Shahid Code =========================
  def search_top_five_food
    @food_search_seeker=PostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'1').group("location_id").order("count(location_id) DESC").limit(5)
    seeker = []
    if !@food_search_seeker.blank?
      @food_search_seeker.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        seeker << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    @food_search_provider=PostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
    provider = []
    if !@food_search_provider.blank?
      @food_search_provider.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        provider << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider}
      end
    end
    respond_to do |format|
      msg = {:seeker => seeker, :provider =>provider }
      format.json { render :json => msg }
    end
  end

  def search_top_five_book
    @book_search_seeker=BookPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'1').group("location_id").order("count(location_id) DESC").limit(5)
    seeker = []
    if !@book_search_seeker.blank?      
      @book_search_seeker.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        seeker << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    @book_search_provider=BookPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
    provider = []
    if !@book_search_provider.blank?
      @book_search_provider.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        provider << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    respond_to do |format|
      msg = {:seeker => seeker, :provider =>provider }
      format.json { render :json => msg }
    end
  end

  def search_top_five_skill
    @skill_search_seeker=SkillPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'1').group("location_id").order("count(location_id) DESC").limit(5)
    seeker = []
    if !@skill_search_seeker.blank?      
      @skill_search_seeker.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        seeker << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    @book_search_provider=SkillPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
    provider = []
    if !@book_search_provider.blank?
      @book_search_provider.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        provider << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    respond_to do |format|
      msg = {:seeker => seeker, :provider =>provider }
      format.json { render :json => msg }
    end
  end

  def book_result
    if params[:seeker_provider] == 'true'
      @prm = true
    else
      @prm = false
    end
    @search_results = BookPostRequirement.where("location_id=? and seeker_provider=?",params[:id],@prm).paginate(:page => params[:page], :per_page => 25)
  end

  def feedback
    @data = {
      :name => params[:name], 
      :email => params[:email],
      :phon => params[:phon], 
      :message => params[:message]
    }
    UserMailer.feed_email(@data).deliver
    respond_to do |format|
      format.js
    end
  end
  def close_window
  end
end
