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

ActiveRecord::Schema.define(:version => 3) do

  create_table "beers", :force => true do |t|
    t.integer "brewery_id"
    t.string  "name"
    t.text    "description"
    t.integer "ibus"
    t.float   "alcohol"
    t.boolean "on_tap",      :default => false
    t.string  "logo_path"
  end

  add_index "beers", ["on_tap"], :name => "index_beers_on_on_tap"

  create_table "breweries", :force => true do |t|
    t.string "name"
    t.string "link"
  end

end
