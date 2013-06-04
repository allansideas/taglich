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

ActiveRecord::Schema.define(:version => 20130604125733) do

  create_table "card_sets", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "cards", :force => true do |t|
    t.integer  "card_set_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "front"
    t.text     "back"
    t.integer  "seen_times"
    t.integer  "correct_count"
    t.integer  "incorrect_count"
    t.datetime "last_seen_at"
    t.datetime "last_interacted_at"
    t.string   "card_symbols"
  end

  create_table "days", :force => true do |t|
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "days", ["date"], :name => "index_days_on_date"
  add_index "days", ["user_id"], :name => "index_days_on_user_id"

  create_table "metric_scores", :force => true do |t|
    t.integer  "day_id"
    t.integer  "metric_id"
    t.integer  "score",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "metric_scores", ["day_id"], :name => "index_metric_scores_on_day_id"
  add_index "metric_scores", ["metric_id"], :name => "index_metric_scores_on_metric_id"

  create_table "metrics", :force => true do |t|
    t.string   "name"
    t.string   "score_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.integer  "sort_order"
    t.string   "state"
    t.datetime "deactivated_on"
  end

  add_index "metrics", ["user_id"], :name => "index_metrics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
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
    t.string   "time_zone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
