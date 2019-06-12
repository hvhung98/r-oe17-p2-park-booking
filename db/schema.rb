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

ActiveRecord::Schema.define(version: 2019_06_08_173119) do

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "orderable_type"
    t.bigint "orderable_id"
    t.string "car_number"
    t.string "type_booked"
    t.integer "status", default: 0
    t.string "month_booked", default: ""
    t.datetime "day_booked"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["orderable_type", "orderable_id"], name: "index_orders_on_orderable_type_and_orderable_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "parkings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "waiting_time"
    t.text "description"
    t.integer "total_position"
    t.integer "avail_position"
    t.decimal "longitude", precision: 10, scale: 7
    t.decimal "latitude", precision: 10, scale: 7
    t.string "status", default: "Mở cửa"
    t.string "address"
    t.time "time_open"
    t.time "time_close"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_parkings_on_user_id"
  end

  create_table "places", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "longitude", precision: 10, scale: 7
    t.decimal "latitude", precision: 10, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "user_id"
    t.bigint "parking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_id"], name: "index_reviews_on_parking_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "role_id", default: 1
    t.string "name"
    t.integer "score", default: 10
    t.string "phone_number", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_img_file_name"
    t.string "user_img_content_type"
    t.integer "user_img_file_size"
    t.datetime "user_img_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "orders", "users"
  add_foreign_key "parkings", "users"
  add_foreign_key "reviews", "parkings"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "roles"
end
