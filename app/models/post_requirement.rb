class PostRequirement < ActiveRecord::Base

  geocoded_by :full_location_address
  #after_validation :geocode, if: ->(obj){ obj.latitude.blank? and obj.longitude.blank? }
  after_validation :geocode, :if => :full_location_address_changed?

  # White list attribute - Mass assignment
  attr_accessible :budget, :city_id, :details, :food_type_id, :location_id, :meal_type_id, 
                  :no_of_persons, :provider_id, :region_id, :seeker_provider, :service_id, 
                  :user_id, :food_image, :latitude, :longitude, :content
 
  # Association
  has_many :orders, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :negotiates, :dependent => :destroy
  has_many :reviews
  belongs_to :user
  belongs_to :city
  belongs_to :food_type
  belongs_to :location
  belongs_to :meal_type
  belongs_to :provider
  belongs_to :region
  belongs_to :service
  belongs_to :sub_category

  #Validations
  # Below mentioned fields are mandatory to post the requirement
  validates :service_id , :provider_id, :city_id, :location_id, :food_type_id,  :presence => true
  validates :no_of_persons, :numericality => {:only_integer => true, :allow_nil => true}

  has_attached_file :food_image, :styles => { :small => "150x150>" },
   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
  #validates_attachment_content_type :food_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'
  validates_attachment_content_type :food_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    def full_location_address
      [self.location.location_name, self.city.city_name, "India"].compact.join(', ')  
    end

    def full_location_address_changed?
      self.location.location_name_changed? || self.city.city_name_changed? || "India"
    end
  
  # This method is use to fetch the records from postrequirement based on user inputs
  def self.filter_conditions( options={} )
    food_type_any = FoodType.find_by_name('Any').id
    meal_type_any = MealType.find_by_name('Any').id
    region_any = Region.find_by_name('Any').id
    caterer = Provider.find_by_provider_type('caterers').id
    chef = Provider.find_by_provider_type('chefs').id

    sql_condition = '1'
    sql_condition_1 = ''

    unless options[:city_id].blank?
      sql_condition += " and city_id = #{options[:city_id]}"
    end

    if options.has_key?("include_near_by_locations")
      
    else
      unless options[:location_id].blank?
        sql_condition += " and location_id = #{options[:location_id]}"
      end
    end

    unless options[:food_type_id].blank?
      food_type = FoodType.find(options[:food_type_id])
      if food_type.name != 'Any'
        sql_condition += " and food_type_id in (#{options[:food_type_id]}, #{food_type_any})"
      end
    end

    unless options[:meal_type_id].blank?
      meal_type = MealType.find(options[:meal_type_id])
      if meal_type.name != 'Any'
        sql_condition += " and meal_type_id in (#{options[:meal_type_id]}, #{meal_type_any})"
      end
    end

    unless options[:region_id].blank?
      region = Region.find(options[:region_id])
      if region.name != 'Any'
        sql_condition += " and region_id in (#{options[:region_id]}, #{region_any})"
      end
    end

    unless options[:identity].blank?
      case options[:identity].to_i
      when 2,3
        sql_condition += " and provider_id = #{chef}"
      when 1,4
        sql_condition += " and provider_id = #{caterer}"
      else
        sql_condition += " "
      end
    end

    sql_condition = sql_condition.insert 0,"("
    sql_condition << ")"

    symbol =''
    
    case options[:food].to_i
    when 0
      sql_condition += " and (seeker_provider = #{false})"
      symbol = '>='
    when 1
      sql_condition += " and (seeker_provider = #{true})"
      symbol = '<='
    when 2
      case options[:identity].to_i
      when 1,2
        sql_condition += " and (seeker_provider = #{true})"
        symbol = '<='
      when 3,4
        sql_condition += " and (seeker_provider = #{false})"
        symbol = '>='
      else
      end
    else
      sql_condition += " "
    end

    unless options[:no_of_persons].blank?
      sql_condition_1 = sql_condition
      sql_condition += " and no_of_persons #{symbol} #{options[:no_of_persons]}"
      sql_condition_1 += " and no_of_persons = -1"
      if options.has_key?("include_near_by_locations")
        location = Location.where("id = ?",options[:location_id]).last
        city = City.where("id = ?",options[:city_id]).last
        search_area = [location.location_name, city.city_name, "India"].join(", ")
        filter_records = PostRequirement.near(search_area, options[:kms].to_i)
#.where(sql_condition).order(:no_of_persons) 
        @result_1 = filter_records.where(sql_condition).order(:no_of_persons)
        @result_2 = filter_records.where(sql_condition_1)
      else 
        
        @result_1 = self.where(sql_condition).order(:no_of_persons)
        @result_2 = self.where(sql_condition_1)
      end 
    end

    if options[:no_of_persons].blank? or symbol == '<='
      if options.has_key?("include_near_by_locations")
        location = Location.where("id = ?",options[:location_id]).last
        city = City.where("id = ?",options[:city_id]).last
        search_area = [location.location_name, city.city_name, "India"].join(", ")
        @results = PostRequirement.near(search_area, options[:kms].to_i, :units => :km).where(sql_condition).order(:no_of_persons)
      else
        @results = self.where(sql_condition).order(:no_of_persons)
      end  
    else
      @results = @result_1 + @result_2
    end
  end
end

