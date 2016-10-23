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

ActiveRecord::Schema.define(version: 20161023102137) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_faces", force: :cascade do |t|
    t.integer  "course_user_id"
    t.string   "fid",            default: ""
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "face_id"
    t.index ["course_user_id", "face_id"], name: "index_course_faces_on_course_user_id_and_face_id"
    t.index ["course_user_id"], name: "index_course_faces_on_course_user_id"
    t.index ["fid"], name: "index_course_faces_on_fid"
  end

  create_table "course_users", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "uid",        default: ""
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["uid"], name: "index_course_users_on_uid"
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "short_link"
    t.integer  "manager_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "gid",        default: ""
    t.string   "attachment"
    t.index ["gid"], name: "index_courses_on_gid"
    t.index ["manager_id"], name: "index_courses_on_manager_id"
  end

  create_table "faces", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "attachment"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "origin_url", default: ""
    t.index ["user_id", "origin_url"], name: "index_faces_on_user_id_and_origin_url"
    t.index ["user_id"], name: "index_faces_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "post_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment"
    t.integer  "width",      default: 0
    t.integer  "height",     default: 0
    t.integer  "status",     default: 0
    t.string   "msg",        default: ""
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "course_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "taken_at"
    t.index ["course_id"], name: "index_posts_on_course_id"
  end

  create_table "tagged_users", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.float    "x"
    t.float    "y"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "fid",        default: ""
    t.index ["fid"], name: "index_tagged_users_on_fid"
    t.index ["photo_id"], name: "index_tagged_users_on_photo_id"
    t.index ["user_id"], name: "index_tagged_users_on_user_id"
    t.index ["x", "y", "width", "height"], name: "index_tagged_users_on_x_and_y_and_width_and_height"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
