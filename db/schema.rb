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

ActiveRecord::Schema.define(:version => 20110615052051) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer   "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "beers", :force => true do |t|
    t.integer  "brewery_id"
    t.string   "name"
    t.text     "description"
    t.integer  "ibus"
    t.float    "alcohol"
    t.boolean  "on_tap",                 :default => false
    t.string   "logo_path"
    t.string   "logo_path_file_name"
    t.string   "logo_path_content_type"
    t.integer  "logo_path_file_size"
    t.datetime "logo_path_updated_at"
  end

  add_index "beers", ["on_tap"], :name => "index_beers_on_on_tap"

  create_table "breweries", :force => true do |t|
    t.string "name"
    t.string "link"
  end

  create_table "kegs", :force => true do |t|
    t.integer   "beer_id"
    t.date      "tapped"
    t.date      "kicked"
    t.decimal   "current_weight"
    t.decimal   "ending_weight"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "kegs", ["beer_id"], :name => "index_kegs_on_beer_id"
  add_index "kegs", ["tapped", "kicked"], :name => "index_kegs_on_tapped_and_kicked"

  create_table "rates", :force => true do |t|
    t.integer "score"
  end

  create_table "ratings", :force => true do |t|
    t.integer   "user_id"
    t.integer   "rate_id"
    t.integer   "rateable_id"
    t.string    "rateable_type", :limit => 32
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "ratings", ["rate_id"], :name => "index_ratings_on_rate_id"
  add_index "ratings", ["rateable_id", "rateable_type"], :name => "index_ratings_on_rateable_id_and_rateable_type"

  create_table "users", :force => true do |t|
    t.string    "identity"
    t.string    "email"
    t.string    "first_name"
    t.string    "last_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
