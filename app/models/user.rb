class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :dob, :phone_no, :city_id, :location, :address, :photo, :admin, :status
  # attr_accessible :title, :body
  has_many :skill_post_requirements, :dependent => :destroy
  has_many :book_post_requirements, :dependent => :destroy
  has_many :post_requirements, :dependent => :destroy
  has_many :negotiates, :dependent => :destroy
  has_many :book_negotiates, :dependent => :destroy
  has_many :messages_in, :class_name => 'Message', :foreign_key => :posted_to, :dependent => :destroy
  has_many :book_messages_in, :class_name => 'BookMessage', :foreign_key => :posted_to, :dependent => :destroy
  has_many :messages_out, :class_name => 'Message', :foreign_key => :user_id, :dependent => :destroy
  has_many :book_messages_out, :class_name => 'BookMessage', :foreign_key => :user_id, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :book_activities, :dependent => :destroy
  has_many :orders_in, :class_name => 'Order', :foreign_key => :provider_id, :dependent => :destroy
  has_many :book_orders_in, :class_name => 'BookOrder', :foreign_key => :provider_id, :dependent => :destroy
  has_many :orders_out, :class_name => 'Order', :foreign_key => :user_id, :dependent => :destroy
  has_many :book_orders_out, :class_name => 'BookOrder', :foreign_key => :user_id, :dependent => :destroy
  belongs_to :city
  
  has_attached_file :photo, :styles => { :small => "150x150>" },
  :path => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
   :url => "/system/:attachment/:id_partition/:style/:basename.:extension"
validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

validates :name, :address, presence: true

validates :phone_no,:presence => true,
                 :numericality => true,
                :length => { :minimum => 10, :maximum => 12}
self.per_page = 15

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |users|
        csv << users.attributes.values_at(*column_names)
      end
    end
  end
end
