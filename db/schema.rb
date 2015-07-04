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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150704043611) do

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "item_name"
    t.decimal  "lending_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "category"
    t.string   "lending_status"
    t.text     "description"
  end

  add_index "items", ["user_id", "created_at"], name: "index_items_on_user_id_and_created_at"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.string   "street"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "zip"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["city"], name: "index_locations_on_city"
  add_index "locations", ["country"], name: "index_locations_on_country"
  add_index "locations", ["item_id"], name: "index_locations_on_item_id"
  add_index "locations", ["state"], name: "index_locations_on_state"

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "photos", ["item_id"], name: "index_photos_on_item_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "item_id"
  end

  add_index "pictures", ["item_id"], name: "index_pictures_on_item_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "lender_id"
    t.integer  "lent_id"
    t.datetime "borrow_date"
    t.datetime "due_date"
    t.string   "request_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reservations", ["item_id"], name: "index_reservations_on_item_id"
  add_index "reservations", ["lender_id", "lent_id"], name: "index_reservations_on_lender_id_and_lent_id"
  add_index "reservations", ["lender_id"], name: "index_reservations_on_lender_id"
  add_index "reservations", ["lent_id"], name: "index_reservations_on_lent_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "organization"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
