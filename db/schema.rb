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

ActiveRecord::Schema.define(version: 2021_12_21_054506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", id: :integer, default: -> { "nextval('categories_category_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "makes", id: :integer, default: -> { "nextval('make_make_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.text "description"
    t.integer "category_id"
  end

  create_table "material_categories", id: :integer, default: -> { "nextval('material_categories_material_category_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "material_category_name", limit: 50, null: false
    t.integer "category_id"
  end

  create_table "records", id: :integer, default: -> { "nextval('record_record_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "description", null: false
    t.integer "make_id"
    t.integer "unit_id", null: false
    t.text "detail"
    t.integer "material_category", null: false
    t.date "date_updated", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "active", default: true, null: false
  end

  create_table "remarks", id: :integer, default: -> { "nextval('remarks_remark_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "record_id", null: false
    t.text "remarks", null: false
    t.date "date_updated", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "active", default: true
  end

  create_table "store_statuses", id: :integer, default: -> { "nextval('store_status_store_status_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "store_status"
    t.date "date_updated", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "active", default: true
  end

  create_table "units", id: :integer, default: -> { "nextval('units_unit_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name", limit: 20, null: false
  end

  add_foreign_key "material_categories", "categories", name: "material_categories_category_id_fkey", on_update: :cascade
  add_foreign_key "records", "makes", name: "record_make_id_fkey", on_update: :cascade
  add_foreign_key "records", "material_categories", column: "material_category", name: "record_material_category_fkey", on_update: :cascade
  add_foreign_key "records", "units", name: "record_unit_id_fkey", on_update: :cascade
  add_foreign_key "remarks", "records", name: "remarks_record_id_fkey", on_update: :cascade
  add_foreign_key "store_statuses", "records", name: "store_status_record_id_fkey", on_update: :cascade
end
