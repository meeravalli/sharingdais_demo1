class BookPostRequirement < ActiveRecord::Base
  	attr_accessible :author, :city_id, :date_of_posting, :description, :isbn_number, :latitude, :location_id, :longitude, :name, :seeker_provider, :service_id, :user_id, :image, :rent, :category_id

    has_many :book_orders, :dependent => :destroy
    has_many :book_messages, :dependent => :destroy
    has_many :book_activities, :dependent => :destroy
    has_many :book_negotiates, :dependent => :destroy
    belongs_to :user
    belongs_to :service
    belongs_to :city
    belongs_to :location
    belongs_to :category
    	
  	geocoded_by :full_location_address
  	#after_validation :geocode, if: ->(obj){ obj.latitude.blank? and obj.longitude.blank? }
    after_validation :geocode, :if => :full_location_address_changed?
    
    def full_location_address
      [self.location.location_name, self.city.city_name, "India"].compact.join(', ')  
    end

    def full_location_address_changed?
      self.location.location_name_changed? || self.city.city_name_changed? || "India"
    end

  	validates :name, presence: true
  	validates :author, presence: true

  	has_attached_file :image, :styles => { :small => "150x150>" },
   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
  	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
end
