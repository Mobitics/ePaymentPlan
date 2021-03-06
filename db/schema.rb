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

ActiveRecord::Schema.define(:version => 20110803052737) do

  create_table "authorize_nets", :force => true do |t|
    t.string   "api_login_id"
    t.string   "transaction_key"
    t.boolean  "test_mode",       :default => false
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.integer  "customer_cim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "orders", :force => true do |t|
    t.float    "amount"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "country"
    t.string   "city"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "zip"
    t.float    "shipping"
    t.float    "tax"
    t.string   "notify_url"
    t.string   "return_url"
    t.string   "cancel_return_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account"
    t.string   "num"
  end

  create_table "payment_plans", :force => true do |t|
    t.integer  "order_id"
    t.float    "amount"
    t.float    "shipping"
    t.float    "tax"
    t.float    "interest"
    t.float    "late_fee"
    t.boolean  "includes_shipping"
    t.boolean  "includes_tax"
    t.integer  "payments_count"
    t.integer  "payment_profile_id"
    t.string   "notify_url"
    t.string   "return_url"
    t.string   "cancel_return_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.string   "frequency",          :default => "monthly"
    t.string   "description"
    t.float    "first_payment_rate", :default => 0.0
    t.boolean  "active",             :default => true
    t.integer  "plan_id"
  end

  create_table "payment_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "payment_cim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "payments", :force => true do |t|
    t.float    "payment"
    t.integer  "payment_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",          :default => "Pending"
  end

  create_table "plans", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payments_count"
    t.boolean  "includes_shipping"
    t.boolean  "includes_tax"
    t.string   "interest"
    t.string   "late_fee"
    t.string   "plan_type"
    t.string   "min_price"
    t.string   "max_price"
    t.integer  "product_id"
    t.string   "name"
    t.integer  "store_id"
    t.string   "frequency",          :default => "monthly"
    t.boolean  "is_readonly",        :default => false
    t.float    "first_payment_rate", :default => 0.0
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.string   "state"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_2"
    t.boolean  "first_step", :default => false
  end

  add_index "stores", ["name"], :name => "index_stores_on_name", :unique => true

  create_table "transactions", :force => true do |t|
    t.string   "confirmation_id"
    t.boolean  "error"
    t.string   "error_code"
    t.string   "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_profile_id"
    t.integer  "payment_id"
    t.string   "auth_code"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_cim_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
