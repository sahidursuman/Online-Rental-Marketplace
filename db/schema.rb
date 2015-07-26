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

ActiveRecord::Schema.define(version: 20150726203013) do

  create_table "calendars", force: :cascade do |t|
    t.integer  "item_id"
    t.datetime "available_from"
    t.datetime "available_to"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "reservation_type"
    t.string   "availability"
  end

  add_index "calendars", ["item_id"], name: "index_calendars_on_item_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "item_name"
    t.decimal  "lending_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "category"
    t.string   "lending_status"
    t.text     "description"
    t.string   "listing_status"
  end

  add_index "items", ["user_id", "created_at"], name: "index_items_on_user_id_and_created_at"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.string   "street"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["item_id"], name: "index_locations_on_item_id"

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"

  create_table "photos", force: :cascade do |t|
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
    t.string   "requested"
  end

  add_index "reservations", ["item_id", "lender_id", "lent_id"], name: "index_reservations_on_item_id_and_lender_id_and_lent_id"
  add_index "reservations", ["item_id"], name: "index_reservations_on_item_id"
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
    t.string   "customer_id"
    t.string   "publishable_key"
    t.string   "uid"
    t.string   "access_code"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
