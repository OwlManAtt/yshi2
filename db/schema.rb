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

ActiveRecord::Schema.define(:version => 20120708021659) do

  create_table "api_keys", :force => true do |t|
    t.integer  "user_id",                                                     :null => false
    t.integer  "identifier",                                                  :null => false
    t.string   "verification_code",          :limit => 64,                    :null => false
    t.integer  "access_mask"
    t.string   "type"
    t.date     "expires_at"
    t.datetime "last_polled_at"
    t.boolean  "deleted",                                  :default => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "last_polled_result_code"
    t.string   "last_polled_result_message"
    t.boolean  "permanent_failure",                        :default => false, :null => false
  end

  create_table "characters", :force => true do |t|
    t.string   "name",           :limit => 24,                    :null => false
    t.integer  "user_id"
    t.integer  "corporation_id"
    t.boolean  "director",                     :default => false, :null => false
    t.boolean  "deleted",                      :default => false, :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "api_key_id"
    t.integer  "eve_id"
  end

  create_table "corporations", :force => true do |t|
    t.string   "name",          :limit => 50,                    :null => false
    t.string   "ticker",        :limit => 5
    t.boolean  "deleted",                     :default => false, :null => false
    t.boolean  "portal_access",               :default => false, :null => false
    t.boolean  "manager",                     :default => false, :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "eve_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "item_blueprint_materials", :force => true do |t|
    t.integer "blueprint_type_id",                  :null => false
    t.integer "material_type_id",                   :null => false
    t.integer "quantity",                           :null => false
    t.float   "damage_per_job",    :default => 1.0
    t.string  "type",                               :null => false
  end

  create_table "item_blueprint_skills", :force => true do |t|
    t.integer "blueprint_type_id", :null => false
    t.integer "skill_type_id",     :null => false
    t.integer "minimum_level",     :null => false
  end

  create_table "item_blueprints", :force => true do |t|
    t.integer "product_type_id",            :null => false
    t.integer "production_time"
    t.integer "productivity_modifier"
    t.integer "waste_factor"
    t.integer "production_limit"
    t.integer "research_material_time"
    t.integer "research_productivity_time"
    t.integer "copy_time"
  end

  create_table "item_categories", :force => true do |t|
    t.string   "name",        :limit => 30, :null => false
    t.text     "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "item_groups", :force => true do |t|
    t.string   "name",           :limit => 60, :null => false
    t.text     "description"
    t.boolean  "manufacturable",               :null => false
    t.boolean  "recyclable",                   :null => false
    t.integer  "category_id",                  :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "item_market_groups", :force => true do |t|
    t.integer "parent_id"
    t.string  "name",        :limit => 50, :null => false
    t.text    "description"
  end

  create_table "item_types", :force => true do |t|
    t.string   "name",            :limit => 100,                                                   :null => false
    t.text     "description"
    t.decimal  "radius",                         :precision => 10, :scale => 0
    t.decimal  "mass",                           :precision => 10, :scale => 0
    t.decimal  "volume",                         :precision => 10, :scale => 0
    t.decimal  "capacity",                       :precision => 10, :scale => 0
    t.integer  "units_per_run"
    t.decimal  "npc_price",                      :precision => 10, :scale => 0
    t.integer  "group_id",                                                                         :null => false
    t.integer  "market_group_id"
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.boolean  "blueprint",                                                     :default => false, :null => false
    t.integer  "metalevel"
    t.integer  "techlevel"
  end

  create_table "users", :force => true do |t|
    t.string   "name",           :limit => 60,                    :null => false
    t.boolean  "deleted",                      :default => false, :null => false
    t.integer  "corporation_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "provider",       :limit => 25
    t.string   "uid"
  end

end
