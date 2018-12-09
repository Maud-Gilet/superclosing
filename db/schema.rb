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

ActiveRecord::Schema.define(version: 2018_12_06_133824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "siren"
    t.string "legal_form"
    t.date "fiscal_date"
    t.date "creation_date"
    t.string "logo_url"
    t.integer "number_of_shares"
    t.integer "share_nominal_value_cents", default: 0, null: false
    t.string "share_nominal_value_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "d_documents", force: :cascade do |t|
    t.bigint "operation_id"
    t.bigint "d_template_id"
    t.string "title"
    t.date "date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["d_template_id"], name: "index_d_documents_on_d_template_id"
    t.index ["operation_id"], name: "index_d_documents_on_operation_id"
  end

  create_table "d_templates", force: :cascade do |t|
    t.string "category"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "operation_id"
    t.integer "number_of_shares"
    t.integer "share_premium_cents", default: 0, null: false
    t.string "share_premium_currency", default: "EUR", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "share_nominal_value_cents", default: 0, null: false
    t.string "share_nominal_value_currency", default: "EUR", null: false
    t.index ["operation_id"], name: "index_investments_on_operation_id"
    t.index ["user_id"], name: "index_investments_on_user_id"
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "company_id"
    t.string "category"
    t.integer "target_amount_cents", default: 0, null: false
    t.string "target_amount_currency", default: "EUR", null: false
    t.date "expected_closing_date"
    t.string "status"
    t.integer "premoney_cents", default: 0, null: false
    t.string "premoney_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["company_id"], name: "index_operations_on_company_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_roles_on_company_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "s_documents", force: :cascade do |t|
    t.bigint "operation_id"
    t.string "title"
    t.string "category"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "d_url"
    t.index ["operation_id"], name: "index_s_documents_on_operation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "birthday"
    t.string "birth_place"
    t.string "linkedin_profile"
    t.string "photo_url"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "d_documents", "d_templates"
  add_foreign_key "d_documents", "operations"
  add_foreign_key "investments", "operations"
  add_foreign_key "investments", "users"
  add_foreign_key "operations", "companies"
  add_foreign_key "roles", "companies"
  add_foreign_key "roles", "users"
  add_foreign_key "s_documents", "operations"
end
