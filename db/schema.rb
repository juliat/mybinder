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

ActiveRecord::Schema.define(:version => 20120824065437) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "rationale"
    t.text     "prior_knowledge"
    t.integer  "topic_id"
    t.integer  "number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "activity_goals", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "goal_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "author_orgs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_classes", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "detailed_activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "file"
    t.integer  "user_id"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "equations", :force => true do |t|
    t.string   "latex"
    t.string   "image_file"
    t.string   "remote_image_url"
    t.integer  "mod_id"
    t.integer  "number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "goal_progresses", :force => true do |t|
    t.integer  "goal_id"
    t.integer  "course_class_id"
    t.boolean  "completed",       :default => false
    t.text     "notes"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "goal_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "goals", :force => true do |t|
    t.string   "statement"
    t.integer  "number"
    t.integer  "goal_type_id"
    t.integer  "topic_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "key_concepts", :force => true do |t|
    t.integer  "unit_id"
    t.integer  "number"
    t.text     "statement"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "key_terms", :force => true do |t|
    t.integer  "unit_id"
    t.string   "term"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "misconceptions", :force => true do |t|
    t.string   "statement"
    t.integer  "topic_id"
    t.integer  "unit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mods", :force => true do |t|
    t.integer  "number"
    t.integer  "days"
    t.integer  "unit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "online_resources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "resourceable_id"
    t.string   "resourceable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "problem_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "standard_goal_mappings", :force => true do |t|
    t.integer  "standard_id"
    t.integer  "goal_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "standards", :force => true do |t|
    t.integer  "unit_id"
    t.string   "author_org_id"
    t.string   "author_org_code"
    t.string   "statement"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "teachers", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "text_references", :force => true do |t|
    t.string   "book"
    t.string   "location"
    t.integer  "textbookable_id"
    t.string   "textbookable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "threshold_problems", :force => true do |t|
    t.integer  "problem_type_id"
    t.integer  "mod_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "mod_id"
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "units", :force => true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "days"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "role"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
