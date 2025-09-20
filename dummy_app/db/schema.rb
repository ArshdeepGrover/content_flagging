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

ActiveRecord::Schema[7.1].define(version: 2025_09_20_174757) do
  create_table "content_flags", force: :cascade do |t|
    t.string "flaggable_type", null: false
    t.integer "flaggable_id", null: false
    t.string "flagged_by_type"
    t.integer "flagged_by_id"
    t.datetime "flagged_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flaggable_type", "flaggable_id", "flagged_by_type", "flagged_by_id"], name: "unique_flag_per_entity", unique: true
    t.index ["flaggable_type", "flaggable_id"], name: "index_content_flags_on_flaggable"
    t.index ["flagged_by_type", "flagged_by_id"], name: "index_content_flags_on_flagged_by"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.integer "flagged_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
