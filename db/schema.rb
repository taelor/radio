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

ActiveRecord::Schema.define(:version => 20120329025741) do

  create_table "conferences", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "name"
    t.boolean  "has_press_pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", :force => true do |t|
    t.datetime "air_datetime"
    t.datetime "recording_datetime"
    t.string   "title"
    t.integer  "guest_id"
    t.integer  "host_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitches", :force => true do |t|
    t.string   "title"
    t.string   "contact_name"
    t.string   "contact_email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_relationships", :force => true do |t|
    t.integer  "guest_id"
    t.integer  "publicist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "episode_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.string   "source"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "bio"
    t.string   "land_line_phone"
    t.string   "cell_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "password_salt"
    t.string   "authentication_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "role_id"
    t.datetime "reset_password_sent_at"
  end

end
