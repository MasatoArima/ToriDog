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

ActiveRecord::Schema.define(version: 2021_11_21_170908) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "request_id", null: false
    t.integer "contract_id"
    t.text "comment"
    t.datetime "first_preferred_date"
    t.datetime "last_preferred_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_applications_on_contract_id"
    t.index ["customer_id"], name: "index_applications_on_customer_id"
    t.index ["request_id"], name: "index_applications_on_request_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.integer "like_id", null: false
    t.integer "get_like_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "room_id", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_chats_on_customer_id"
    t.index ["room_id"], name: "index_chats_on_room_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone_number"
    t.string "subject", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "application_id", null: false
    t.integer "evaluation_id"
    t.integer "is_status", null: false
    t.boolean "dog_owner_is_consent", default: false, null: false
    t.boolean "trimmer_is_consent", default: false, null: false
    t.datetime "preferred_date"
    t.integer "client_id", null: false
    t.integer "trimmer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_contracts_on_application_id"
    t.index ["evaluation_id"], name: "index_contracts_on_evaluation_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "prefecture_code", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "other_address"
    t.string "post_code", null: false
    t.string "phone_number", null: false
    t.boolean "is_deleted", default: false, null: false
    t.integer "user_status", null: false
    t.text "introduction"
    t.string "profile_image"
    t.float "lat"
    t.float "lng"
    t.integer "info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["info_id"], name: "index_customers_on_info_id"
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "dogs", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "name", null: false
    t.string "name_kana", null: false
    t.string "breed", null: false
    t.boolean "sex", null: false
    t.integer "size", null: false
    t.boolean "is_inoculate", null: false
    t.string "inoculation_date"
    t.text "introduction"
    t.string "profile_image"
    t.string "birthday", null: false
    t.string "medical_history"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_dogs_on_customer_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_entries_on_customer_id"
    t.index ["room_id"], name: "index_entries_on_room_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.float "rate"
    t.text "comment"
    t.integer "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_evaluations_on_contract_id"
  end

  create_table "infos", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "best_breed"
    t.string "best_cut"
    t.integer "price_large"
    t.integer "price_medium"
    t.integer "price_small"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_infos_on_customer_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "contract_id", null: false
    t.integer "customer_id", null: false
    t.string "sender", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_messages_on_contract_id"
    t.index ["customer_id"], name: "index_messages_on_customer_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "dog_id", null: false
    t.text "comment"
    t.string "prefecture_code", null: false
    t.boolean "is_complete", default: false, null: false
    t.datetime "first_preferred_date"
    t.datetime "last_preferred_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_requests_on_customer_id"
    t.index ["dog_id"], name: "index_requests_on_dog_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
