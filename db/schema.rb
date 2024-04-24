# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_23_212859) do
  create_table "base_prices", force: :cascade do |t|
    t.decimal "minimum_value", precision: 12, scale: 2
    t.decimal "additional_value_per_person", precision: 12, scale: 2
    t.decimal "extra_hour_value", precision: 12, scale: 2
    t.integer "event_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["event_type_id"], name: "index_base_prices_on_event_type_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "telephone"
    t.string "email"
    t.string "address"
    t.string "district"
    t.string "cep"
    t.string "city"
    t.string "state"
    t.string "description"
    t.string "payment_methods"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_buffets_on_user_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "capacity_min"
    t.integer "capacity_max"
    t.integer "duration"
    t.text "food_menu"
    t.boolean "alcoholic_drinks"
    t.boolean "decoration"
    t.boolean "parking_service"
    t.boolean "buffet_exclusive_address"
    t.boolean "client_specified_address"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name"
    t.string "individual_registration"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "base_prices", "event_types"
  add_foreign_key "buffets", "users"
  add_foreign_key "event_types", "buffets"
end
