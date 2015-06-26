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
      @city = City.where(:id => city).first
      @location = Location.where(:id => location).first
      query = ""
      # if params[:search][:book] == "0"
      #   query += "seeker_provider = 0"
      # else
      #    query += "seeker_provider = 1"
      # end
       query += "seeker_provider = 0"
      
      if key.present?
      
        category=Category.where("category_name=?",params[:search][:key])
        if !category.blank?
          @ke = category.first.id.to_s
        else
          @ke = key
        end
        query += ' and (lower(name) LIKE "%' + key + '%" or lower(category_id) LIKE "%' + @ke + '%" or lower(author) LIKE "%' + key + '%")'
      end
     
      if params[:search].has_key?("include_near_by_locations")
       
        location = Location.where("id = ?",params[:search][:location_id]).last
        city = City.where("id = ?",params[:search][:city_id]).last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = BookPostRequirement.near("#{search_area}", 10).where(query)
      p @search_results.inspect      
      else
       
        @search_results = BookPostRequirement.where(query).paginate(:page => params[:page], :per_page => 25)
      end
      @search_params = @search_results.count
      @locations = params[:search][:city_id].blank? ? [] : City.find(params[:search][:city_id]).locations
    elsif params[:city].present?
    
      key = params[:value].downcase
      # @city = City.where(:id => params[:city]).first
      # @location = Location.where(:id => params[:location]).first
      query = ""
      if params[:t] == "0"
        query += "seeker_provider = 0"
      else
        query += "seeker_provider = 1"
      end
        # query += "seeker_provider = 0"
      if key.present?
       
        category=Category.where("category_name=?",params[:key])
        if !category.blank?
          @ke = category.first.id.to_s
        else
          @ke = key
        end
        query += ' and (lower(name) LIKE "%' + key + '%" or lower(category_id) LIKE "%' + @ke + '%" or lower(author) LIKE "%' + key + '%")'
      end
        l = Location.where(:location_name => params[:location]).first
        c = City.where(:city_name => params[:city]).first
        location = Location.where("id = ?","#{l.id}").last
        city = City.where("id = ?","#{c.id}").last
        search_area = [city.city_name, location.location_name, "India"].join(", ")
        @search_results = BookPostRequirement.near("#{search_area}", 10).where(query).paginate(:page => params[:page], :per_page => 15)
      @search_params = @search_results.count
      @locations = params[:city].blank? ? [] : City.where(:city_name => params[:city]).first.locations
    end
    redirect_to "/#{@city.city_name}/#{@location.location_name}/book_search?value=#{params[:search][:key]}&t=0" unless @city.nil?
    #end
    @page = params[:page] || 1
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
  

   def search_top_five_peer
    @rider_search_seeker=PeerServicePostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'1').group("location_id").order("count(location_id) DESC").limit(5)
    seeker = []
    if !@rider_search_seeker.blank?      
      @rider_search_seeker.each do |loca|
        location_dtls=Location.where("id=?",loca.location_id)
        seeker << { location_name: location_dtls.first.location_name, :l_id => loca.location_id, :seeker_provider => loca.seeker_provider }
      end
    end
    @rider_search_provider=PeerServicePostRequirement.where("city_id=? AND seeker_provider=?",params[:cityid],'0').group("location_id").order("count(location_id) DESC").limit(5)
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
    if params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
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
    elsif params[:box_1].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
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
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
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
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
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
    elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
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
     elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_6 => params[:box_6])
        @cnt.save
      else
        @cnt=@mycounter.first.box_6
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_6 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_6 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_7 => params[:box_7])
        @cnt.save
      else
        @cnt=@mycounter.first.box_7
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_7 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_7 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_8 => params[:box_8])
        @cnt.save
      else
        @cnt=@mycounter.first.box_8
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_8 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_8 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_9 => params[:box_9])
        @cnt.save
      else
        @cnt=@mycounter.first.box_9
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_9 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_9 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_10 => params[:box_10])
        @cnt.save
      else
        @cnt=@mycounter.first.box_10
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_10 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_10 = @cnt + 1
          @sv.first.save
        end
      end
      
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_11 => params[:box_11])
        @cnt.save
      else
        @cnt=@mycounter.first.box_11
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_11 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_11 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_12 => params[:box_12])
        @cnt.save
      else
        @cnt=@mycounter.first.box_12
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_12 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_12 = @cnt + 1
          @sv.first.save
        end
      end
       elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_13 => params[:box_13])
        @cnt.save
      else
        @cnt=@mycounter.first.box_13
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_13 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_13 = @cnt + 1
          @sv.first.save
        end
      end
       elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_14 => params[:box_14])
        @cnt.save
      else
        @cnt=@mycounter.first.box_14
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_14 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_14 = @cnt + 1
          @sv.first.save
        end
      end
       elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_15 => params[:box_15])
        @cnt.save
      else
        @cnt=@mycounter.first.box_15
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_15 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_15 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_16 => params[:box_16])
        @cnt.save
      else
        @cnt=@mycounter.first.box_16
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_16 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_16 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_18].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_17 => params[:box_17])
        @cnt.save
      else
        @cnt=@mycounter.first.box_17
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_17 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_17 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_19].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_18 => params[:box_18])
        @cnt.save
      else
        @cnt=@mycounter.first.box_18
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_18 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_18 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_20].nil?
      if @mycounter.count == 0
        @cnt=Ad.new(:box_19 => params[:box_19])
        @cnt.save
      else
        @cnt=@mycounter.first.box_19
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_19 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_19 = @cnt + 1
          @sv.first.save
        end
      end
      elsif params[:box_1].nil? && params[:box_2].nil? && params[:box_3].nil? && params[:box_4].nil? && params[:box_5].nil? && params[:box_6].nil? && params[:box_7].nil? && params[:box_8].nil? && params[:box_9].nil? && params[:box_10].nil? && params[:box_11].nil? && params[:box_12].nil? && params[:box_13].nil? && params[:box_14].nil? && params[:box_15].nil? && params[:box_16].nil? && params[:box_17].nil? && params[:box_18].nil? && params[:box_19].nil? 
      if @mycounter.count == 0
        @cnt=Ad.new(:box_20 => params[:box_20])
        @cnt.save
      else
        @cnt=@mycounter.first.box_20
        if @cnt.nil?
          @sv=Ad.where("id=?",1)
          @sv.first.box_20 =1
          @sv.first.save
        else
          @sv=Ad.where("id=?",1)
          @sv.first.box_20 = @cnt + 1
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



  def check_phoneno
    puts "===============#{params[:phoneno]}=================="
    @phone_no=User.where("phone_no=?", params[:phoneno]).first
    unless @phone_no.nil?
      p 11111111111111111111111111
      render :json => { :status => "ok" }
    else
      p 222222222222222222222222222222
      render :json => { :status => "no" }
    end
  end

end