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

ActiveRecord::Schema.define(:version => 20110526233130) do

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

  create_table "payment_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "payment_cim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "transactions", :force => true do |t|
    t.string   "confirmation_id"
    t.boolean  "error"
    t.string   "error_code"
    t.string   "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "customer_cim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
