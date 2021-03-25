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

ActiveRecord::Schema.define(version: 2021_03_25_115603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "role", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", null: false
    t.string "surname", null: false
    t.string "patronymic", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "short_description", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "admin_id", null: false
    t.index ["admin_id"], name: "index_articles_on_admin_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "requisites", null: false
    t.text "description"
    t.float "rating"
    t.string "website"
    t.string "phone_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
  end

  create_table "company_cities", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_company_cities_on_city_id"
    t.index ["company_id", "city_id"], name: "index_company_cities_on_company_id_and_city_id", unique: true
    t.index ["company_id"], name: "index_company_cities_on_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "state", null: false
    t.datetime "date_start", null: false
    t.datetime "date_end"
    t.float "review", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_price_id"
    t.integer "price"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["service_price_id"], name: "index_orders_on_service_price_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.string "state", null: false
    t.string "file"
    t.string "file_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_reports_on_admin_id"
  end

  create_table "service_prices", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "city_id", null: false
    t.bigint "company_id", null: false
    t.integer "price", null: false
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_service_prices_on_city_id"
    t.index ["company_id"], name: "index_service_prices_on_company_id"
    t.index ["service_id"], name: "index_service_prices_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "admins"
  add_foreign_key "company_cities", "cities"
  add_foreign_key "company_cities", "companies"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "service_prices"
  add_foreign_key "reports", "admins"
  add_foreign_key "service_prices", "cities"
  add_foreign_key "service_prices", "companies"
  add_foreign_key "service_prices", "services"
end
