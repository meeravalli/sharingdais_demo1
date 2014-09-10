class BookPostRequirement < ActiveRecord::Base
  	attr_accessible :author, :city_id, :date_of_posting, :description, :isbn_number, :latitude, :location_id, :longitude, :name, :seeker_provider, :service_id, :user_id, :image, :rent

    has_many :book_orders, :dependent => :destroy
    has_many :book_messages, :dependent => :destroy
    has_many :book_activities, :dependent => :destroy
    has_many :book_negotiates, :dependent => :destroy
    belongs_to :user
    belongs_to :city
    belongs_to :location
    	
  	geocoded_by :full_location_address
  	after_validation :geocode, if: ->(obj){ obj.latitude.blank? and obj.longitude.blank? }

  	validates :name, presence: true
  	validates :author, presence: true

  	has_attached_file :image, :styles => { :small => "150x150>" },
   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
  	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def full_location_address
  	[self.location.location_name, self.city.city_name, "India"].compact.join(', ')  
	end
end
