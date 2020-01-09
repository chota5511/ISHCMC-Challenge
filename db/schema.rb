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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Administrators", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.serial "UserID", null: false
    t.boolean "Enabled"
  end

  create_table "CampusStaffs", primary_key: ["CampusID", "UserID"], force: :cascade do |t|
    t.text "CampusID", null: false
    t.serial "UserID", null: false
  end

  create_table "Campuses", primary_key: "ID", id: :text, force: :cascade do |t|
    t.text "Name"
    t.text "Address"
  end

  create_table "NonTeachingPositions", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.text "Name"
    t.text "Description"
  end

  create_table "NonTeachingStaffs", primary_key: ["PositionID", "UserID"], force: :cascade do |t|
    t.serial "PositionID", null: false
    t.serial "UserID", null: false
  end

  create_table "TeachingStaffs", primary_key: ["PositionID", "UserID"], force: :cascade do |t|
    t.serial "PositionID", null: false
    t.serial "UserID", null: false
  end

  create_table "TechingPositions", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.text "Name"
    t.text "Desctiption"
  end

  create_table "Users", primary_key: "ID", id: :serial, force: :cascade do |t|
    t.text "UserName", null: false
    t.text "Password"
    t.text "PwHash"
    t.text "Name", null: false
    t.bigint "Phone"
    t.text "Address"
    t.boolean "Enabled"
    t.text "Email"
    t.index ["Email"], name: "Email_uq", unique: true
    t.index ["Phone"], name: "Phone_uq", unique: true
    t.index ["UserName"], name: "UserName_uq", unique: true
  end

  add_foreign_key "Administrators", "\"Users\"", column: "UserID", primary_key: "ID", name: "UserID_fk", on_update: :cascade, on_delete: :restrict
  add_foreign_key "CampusStaffs", "\"Campuses\"", column: "CampusID", primary_key: "ID", name: "CampusID_fk", on_update: :cascade
  add_foreign_key "CampusStaffs", "\"Users\"", column: "UserID", primary_key: "ID", name: "UserID_fk", on_update: :cascade
  add_foreign_key "NonTeachingStaffs", "\"NonTeachingPositions\"", column: "PositionID", primary_key: "ID", name: "PositionID_fk", on_update: :cascade, on_delete: :restrict
  add_foreign_key "NonTeachingStaffs", "\"Users\"", column: "UserID", primary_key: "ID", name: "UserID_fk", on_update: :cascade, on_delete: :restrict
  add_foreign_key "TeachingStaffs", "\"TechingPositions\"", column: "PositionID", primary_key: "ID", name: "PositionID_fk", on_update: :cascade, on_delete: :restrict
  add_foreign_key "TeachingStaffs", "\"Users\"", column: "UserID", primary_key: "ID", name: "UserID_fk"
end
