class SkillPostRequirement < ActiveRecord::Base
  belongs_to :service
  belongs_to :city
  belongs_to :location
  belongs_to :sub_category
  belongs_to :user
  has_many :reviews
  has_many :negotiates, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  attr_accessible :service_id, :city_id, :location_id, :sub_category_id, :user_id, :charges, :description, :fri, :home_service, :latitude, :longitude, :mon, :sat, :seeker_provider, :service_in_one_line, :sun, :thu, :tue, :wed, :skill, :content
  
  geocoded_by :full_location_address 
  #after_validation :geocode, if: ->(obj){ obj.latitude.blank? and obj.longitude.blank? }
  after_validation :geocode, :if => :full_location_address_changed?
    
  def full_location_address
    [self.location.location_name, self.city.city_name, "India"].compact.join(', ')  
  end

  def full_location_address_changed?
    self.location.location_name_changed? || self.city.city_name_changed? || "India"
  end

  validates :sub_category_id, presence: true

  has_attached_file :skill, :styles => { :small => "150x150>" },
   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
  #validates_attachment_content_type :food_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'
  validates_attachment_content_type :skill, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
