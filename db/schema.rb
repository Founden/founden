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

ActiveRecord::Schema.define(version: 20140103195909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attachments", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "type"
    t.hstore   "data"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.integer  "message_id"
    t.integer  "summary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["conversation_id"], name: "index_attachments_on_conversation_id", using: :btree
  add_index "attachments", ["message_id"], name: "index_attachments_on_message_id", using: :btree
  add_index "attachments", ["slug"], name: "index_attachments_on_slug", unique: true, using: :btree
  add_index "attachments", ["summary_id"], name: "index_attachments_on_summary_id", using: :btree
  add_index "attachments", ["type"], name: "index_attachments_on_type", using: :btree
  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.hstore   "data"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["slug"], name: "index_conversations_on_slug", unique: true, using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "identities", force: true do |t|
    t.string   "uid",          default: [], array: true
    t.string   "token"
    t.string   "account_type"
    t.integer  "account_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["uid"], name: "index_identities_on_uid", using: :gin

  create_table "invitations", force: true do |t|
    t.string   "slug"
    t.string   "email"
    t.integer  "user_id"
    t.integer  "membership_id"
    t.string   "membership_type"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", using: :btree
  add_index "invitations", ["membership_id", "membership_type"], name: "index_invitations_on_membership_id_and_membership_type", using: :btree
  add_index "invitations", ["slug"], name: "index_invitations_on_slug", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "creator_id"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.hstore   "data"
    t.string   "type"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["conversation_id"], name: "index_memberships_on_conversation_id", using: :btree
  add_index "memberships", ["creator_id"], name: "index_memberships_on_creator_id", using: :btree
  add_index "memberships", ["slug"], name: "index_memberships_on_slug", unique: true, using: :btree
  add_index "memberships", ["type"], name: "index_memberships_on_type", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "content"
    t.string   "slug"
    t.hstore   "data"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.integer  "summary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_message_id"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["parent_message_id"], name: "index_messages_on_parent_message_id", using: :btree
  add_index "messages", ["slug"], name: "index_messages_on_slug", unique: true, using: :btree
  add_index "messages", ["summary_id"], name: "index_messages_on_summary_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "queue_classic_jobs", force: true do |t|
    t.text     "q_name",    null: false
    t.text     "method",    null: false
    t.json     "args",      null: false
    t.datetime "locked_at"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "summaries", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.hstore   "data"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "summaries", ["conversation_id"], name: "index_summaries_on_conversation_id", using: :btree
  add_index "summaries", ["slug"], name: "index_summaries_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "slug"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "data"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
