# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_14_162300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: :cascade do |t|
    t.string "name", null: false
    t.integer "description", null: false
    t.bigint "rarity_id", null: false
    t.bigint "university_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rarity_id"], name: "index_badges_on_rarity_id"
    t.index ["university_id"], name: "index_badges_on_university_id"
  end

  create_table "codes", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_codes_on_user_id"
    t.index ["value"], name: "index_codes_on_value", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.string "name", null: false
    t.integer "scores_count", default: 0, null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.boolean "confirmed?", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["badge_id"], name: "index_participations_on_badge_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "rarities", force: :cascade do |t|
    t.string "name"
    t.integer "scores_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "group_number", null: false
    t.string "phone_number", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "university_id"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["university_id"], name: "index_users_on_university_id"
  end

  add_foreign_key "badges", "rarities"
  add_foreign_key "badges", "universities"
  add_foreign_key "codes", "users"
  add_foreign_key "participations", "badges"
  add_foreign_key "participations", "users"
  add_foreign_key "users", "universities"
end
