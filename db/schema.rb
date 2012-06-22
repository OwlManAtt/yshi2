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

ActiveRecord::Schema.define(:version => 20120621034714) do

  create_table "characters", :force => true do |t|
    t.string   "name",             :limit => 24,                    :null => false
    t.integer  "user_id"
    t.integer  "corporation_id"
    t.integer  "api_user_id"
    t.integer  "api_character_id"
    t.string   "api_key",          :limit => 64
    t.boolean  "director",                       :default => false, :null => false
    t.boolean  "deleted",                        :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "corporations", :force => true do |t|
    t.string   "name",          :limit => 50,                    :null => false
    t.string   "ticker",        :limit => 5,                     :null => false
    t.boolean  "deleted",                     :default => false, :null => false
    t.boolean  "portal_access",               :default => false, :null => false
    t.boolean  "manager",                     :default => false, :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",           :limit => 60,                    :null => false
    t.boolean  "deleted",                      :default => false, :null => false
    t.integer  "corporation_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

end
