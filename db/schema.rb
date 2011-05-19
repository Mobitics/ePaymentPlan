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

ActiveRecord::Schema.define(:version => 20110519012753) do

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
  end

end
