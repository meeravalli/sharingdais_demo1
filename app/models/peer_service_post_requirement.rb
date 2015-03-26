class PeerServicePostRequirement < ActiveRecord::Base
  attr_accessible :additinal_info, :charges, :city_id, :degree, :exp, :fri, :latitude, :location_id, :longitude, :mon, :peer_category_id, :peer_content_type, :peer_file_name, :peer_file_size, :peer_updated_at, :review, :sat, :seeker_provider, :service_id, :speciality, :sun, :thu, :tue, :user_id, :wed, :peer
 belongs_to :service
 belongs_to :city
 belongs_to :location
 belongs_to :peer_category
 belongs_to :user
 has_many :reviews
 has_many :peer_negotiates, :dependent => :destroy
 has_many :peer_messages, :dependent => :destroy
 has_many :peer_orders, :dependent => :destroy
 has_many :peer_activities, :dependent => :destroy
 geocoded_by :full_location_address
    #after_validation :geocode, if: ->(obj){ obj.latitude.blank? and obj.longitude.blank? }
    after_validation :geocode, :if => :full_location_address_changed?
   
    def full_location_address
      [self.location.location_name, self.city.city_name, "India"].compact.join(', ') 
    end

    def full_location_address_changed?
      self.location.location_name_changed? || self.city.city_name_changed? || "India"
    end

  validates :peer_category_id, presence: true

  has_attached_file :peer, :styles => { :small => "150x150>" },
   :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
  #validates_attachment_content_type :food_image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'
  validates_attachment_content_type :peer, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
