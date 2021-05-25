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

ActiveRecord::Schema.define(version: 2021_05_25_162902) do

  create_table "allergies", force: :cascade do |t|
    t.integer "users_id"
    t.string "medicine_name"
    t.string "side_effect"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_allergies_on_users_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.integer "users_id"
    t.string "medicine_name"
    t.text "description"
    t.integer "total_amount"
    t.integer "remain_amount"
    t.string "medicine_unit"
    t.integer "dosage_amount"
    t.string "medicine_image"
    t.string "medicine_leaflet"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_medicines_on_users_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "medicines_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_reminders_id"
    t.index ["medicines_id"], name: "index_reminders_on_medicines_id"
    t.index ["user_reminders_id"], name: "index_reminders_on_user_reminders_id"
  end

  create_table "usage_histories", force: :cascade do |t|
    t.integer "users_id"
    t.integer "medicines_id"
    t.integer "amount"
    t.integer "amount_unit"
    t.date "date"
    t.time "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "time_type"
    t.index ["medicines_id"], name: "index_usage_histories_on_medicines_id"
    t.index ["users_id"], name: "index_usage_histories_on_users_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer "users_id"
    t.integer "gender", default: 0
    t.date "birthdate"
    t.float "weight"
    t.float "height"
    t.boolean "isG6PD"
    t.boolean "isLiver"
    t.boolean "isKidney"
    t.boolean "isGastritis"
    t.boolean "isBreastfeeding"
    t.boolean "isPregnant"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_user_infos_on_users_id"
  end

  create_table "user_reminders", force: :cascade do |t|
    t.integer "users_id"
    t.integer "time_type"
    t.time "time"
    t.index ["users_id"], name: "index_user_reminders_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_pic"
  end

  add_foreign_key "reminders", "user_reminders", column: "user_reminders_id"
end
