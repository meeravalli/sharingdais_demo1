class BookSearchController < ApplicationController
  layout 'book_search'
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
        category=Category.where("category_name=?",params[:search][:key])
        if !category.blank?
          @ke = category.first.id.to_s  
        else  
          @ke = key       
        end 
        query += ' and (lower(name) LIKE "%' + key + '%" or lower(category_id) LIKE "%' + @ke + '%" or lower(author) LIKE "%' + key + '%")'
      end
      #if city.present?
          #query += " and city_id = #{city}"
      #end      
      #if location.present?
          #query += " and location_id = #{location}"
      #end
      if params[:search].has_key?("include_near_by_locations")
        location = Location.where("id = ?",params[:search][:location_id]).last
        city = City.where("id = ?",params[:search][:city_id]).last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = BookPostRequirement.near("#{search_area}", 10).where(query).paginate(:page => params[:page], :per_page => 15)    
      else
        @search_results = BookPostRequirement.where(query).paginate(:page => params[:page], :per_page => 15)
      end 
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
    @skill_search_provider=SkillPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
    provider = []
    if !@skill_search_provider.blank?
      @skill_search_provider.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        provider << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    respond_to do |format|
      msg = {:seeker => seeker, :provider =>provider }
      format.json { render :json => msg }
    end
  end
  
=begin
   def search_top_five_ride
    @rider_search_seeker=RiderPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'1').group("location_id").order("count(location_id) DESC").limit(5)
    seeker = []
    if !@rider_search_seeker.blank?      
      @rider_search_seeker.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        seeker << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    @rider_search_provider=RiderPostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
    provider = []
    if !@rider_search_provider.blank?
      @rider_search_provider.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        provider << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    respond_to do |format|
      msg = {:seeker => seeker, :provider =>provider }
      format.json { render :json => msg }
    end
  end
=end

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

  def save_count
    @mycounter=Ad.all
    if params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_1 => params[:box_1])
        @cnt.save
      else
        @cnt=@mycounter.first.box_1
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_1 =1
          @sv.first.save          
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_1 = @cnt + 1
          @sv.first.save   
        end        
      end
    elsif params[:box_1].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_2 => params[:box_2])
        @cnt.save
      else
        @cnt=@mycounter.first.box_2
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_2 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_2 =@cnt + 1
          @sv.first.save
        end       
      end
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_4].nil? && params[:box_5].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_3 => params[:box_3])
        @cnt.save
      else
        @cnt=@mycounter.first.box_3
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_3 =1
          @sv.first.save        
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_3 = @cnt + 1
          @sv.first.save 
        end
      end
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_5].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_4 => params[:box_4])
        @cnt.save
      else
        @cnt=@mycounter.first.box_4
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_4 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_4 = @cnt + 1
          @sv.first.save
        end
      end
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_5 => params[:box_5])
        @cnt.save
      else
        @cnt=@mycounter.first.box_5
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_5 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_5 = @cnt + 1
          @sv.first.save
        end
      end
    end
    render :json => {:status => "ok"}
  end

  def check_email
    puts "===============#{params[:email]}=================="
    @email=User.where("email=?", params[:email]).count()
    if @email == 0
      render :json => { :status => "ok" }
    else
      render :json => { :status => "no" }
    end
  end

end