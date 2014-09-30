# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140929102808) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "order_id"
    t.integer  "post_requirement_id"
    t.boolean  "seeked_shared",       :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "book_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "book_order_id"
    t.integer  "book_post_requirement_id"
    t.boolean  "seeked_shared",            :default => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "book_messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "posted_to"
    t.text     "content"
    t.boolean  "read"
    t.string   "subject"
    t.boolean  "order_status"
    t.boolean  "accepted"
    t.boolean  "trashed"
    t.integer  "book_post_requirement_id"
    t.integer  "location_id"
    t.integer  "book_order_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "book_negotiates", :force => true do |t|
    t.integer  "book_post_requirement_id"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "nego_id"
  end

  create_table "book_order_cancels", :force => true do |t|
    t.integer  "book_order_id"
    t.date     "cancel_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "book_orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.integer  "book_post_requirement_id"
    t.date     "order_date"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "book_post_requirements", :force => true do |t|
    t.integer  "service_id"
    t.integer  "city_id"
    t.integer  "location_id"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.string   "name"
    t.string   "author"
    t.integer  "user_id"
    t.boolean  "seeker_provider"
    t.string   "isbn_number"
    t.date     "date_of_posting"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "rent"
  end

  create_table "cities", :force => true do |t|
    t.string   "city_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "food_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "location_name"
    t.integer  "city_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "meal_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "posted_to"
    t.boolean  "read",                :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "subject"
    t.boolean  "order_status",        :default => false
    t.boolean  "accepted",            :default => false
    t.boolean  "trashed",             :default => false
    t.integer  "post_requirement_id"
    t.string   "food"
    t.string   "location"
    t.integer  "order_id"
  end

  create_table "negotiates", :force => true do |t|
    t.integer  "post_requirement_id"
    t.string   "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "nego_id"
  end

  create_table "order_cancels", :force => true do |t|
    t.integer  "order_id"
    t.date     "cancel_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer "user_id"
    t.integer "provider_id"
    t.integer "post_requirement_id"
    t.date    "order_date"
  end

  create_table "post_requirements", :force => true do |t|
    t.integer  "service_id"
    t.integer  "provider_id"
    t.integer  "city_id"
    t.integer  "location_id"
    t.integer  "food_type_id"
    t.integer  "meal_type_id"
    t.integer  "region_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "no_of_persons"
    t.decimal  "budget",                  :precision => 8, :scale => 2
    t.text     "details"
    t.integer  "user_id"
    t.boolean  "seeker_provider",                                       :default => true
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.string   "food_image_file_name"
    t.string   "food_image_content_type"
    t.integer  "food_image_file_size"
    t.datetime "food_image_updated_at"
  end

  create_table "providers", :force => true do |t|
    t.string   "provider_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rates", :force => true do |t|
    t.integer  "negotiate_id"
    t.integer  "book_negotiate_id"
    t.integer  "user_id"
    t.integer  "rated_id"
    t.integer  "post_requirement_id"
    t.integer  "book_post_requirement_id"
    t.integer  "rated_no"
    t.string   "service_type"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "rates", ["book_negotiate_id"], :name => "index_rates_on_book_negotiate_id"
  add_index "rates", ["book_post_requirement_id"], :name => "index_rates_on_book_post_requirement_id"
  add_index "rates", ["negotiate_id"], :name => "index_rates_on_negotiate_id"
  add_index "rates", ["post_requirement_id"], :name => "index_rates_on_post_requirement_id"
  add_index "rates", ["user_id"], :name => "index_rates_on_user_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "service_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0,     :null => false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.date     "dob"
    t.string   "phone_no"
    t.integer  "city_id"
    t.string   "location"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "address"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "admin",                  :default => false
    t.boolean  "status",                 :default => true
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
