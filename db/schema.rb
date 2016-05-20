# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160518160732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "case_studies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "client"
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "template_content"
    t.text     "template_compiled"
    t.text     "tile_template_content"
    t.text     "tile_template_compiled"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "template_id"
    t.string   "step"
  end

  add_index "case_studies", ["url"], name: "index_case_studies_on_url", using: :btree
  add_index "case_studies", ["user_id"], name: "index_case_studies_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "sender"
    t.string   "reply_to"
    t.string   "subject"
    t.text     "message"
    t.string   "token"
    t.string   "status"
    t.integer  "request_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "role"
    t.string   "company"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "title"
    t.text     "content"
    t.integer  "rating"
    t.boolean  "published",          default: false
    t.boolean  "approved",           default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "type"
    t.string   "title"
    t.string   "description"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.text     "template"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "templates", ["type"], name: "index_templates_on_type", using: :btree

  create_table "testimonial_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "sender"
    t.string   "reply_to"
    t.text     "message"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "subject"
    t.string   "token"
    t.string   "status"
    t.integer  "testimonial_id"
  end

  add_index "testimonial_requests", ["testimonial_id"], name: "index_testimonial_requests_on_testimonial_id", using: :btree
  add_index "testimonial_requests", ["user_id"], name: "index_testimonial_requests_on_user_id", using: :btree

  create_table "testimonials", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "role"
    t.string   "company"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "content"
    t.text     "template_compiled"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "published",          default: false
    t.boolean  "approved",           default: false
  end

  add_index "testimonials", ["user_id"], name: "index_testimonials_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "domain"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["url"], name: "index_users_on_url", using: :btree

  add_foreign_key "case_studies", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "testimonial_requests", "testimonials"
  add_foreign_key "testimonial_requests", "users"
  add_foreign_key "testimonials", "users"
end
