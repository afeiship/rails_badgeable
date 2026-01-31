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

ActiveRecord::Schema[8.1].define(version: 2025_01_31_000001) do
  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "rails_badgeable_assignments", force: :cascade do |t|
    t.integer "assignable_id", null: false
    t.string "assignable_type", null: false
    t.integer "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id", "assignable_type", "assignable_id"], name: "index_badge_assignments", unique: true
    t.index ["badge_id"], name: "index_rails_badgeable_assignments_on_badge_id"
  end

  create_table "rails_badgeable_badges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rails_badgeable_badges_on_name", unique: true
  end

  add_foreign_key "rails_badgeable_assignments", "rails_badgeable_badges", column: "badge_id"
end
