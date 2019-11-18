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

ActiveRecord::Schema.define(version: 20191116173601) do

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id",    limit: 4
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id",   limit: 4
    t.string   "associated_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes", limit: 65535
    t.integer  "version",         limit: 4,     default: 0
    t.datetime "created_at"
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.string   "request_uuid",    limit: 255
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["associated_id", "associated_type"], name: "auditable_parent_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "auth_tokens", force: :cascade do |t|
    t.integer  "domain_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "token",       limit: 255,   null: false
    t.text     "permissions", limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_at",                null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "domain_id",   limit: 4
    t.string   "name",        limit: 255
    t.string   "type",        limit: 255
    t.integer  "modified_at", limit: 4
    t.string   "account",     limit: 255
    t.text     "comment",     limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["domain_id", "modified_at"], name: "index_comments_on_domain_id_and_modified_at", using: :btree
  add_index "comments", ["domain_id"], name: "index_comments_on_domain_id", using: :btree
  add_index "comments", ["name", "type"], name: "index_comments_on_name_and_type", using: :btree

  create_table "cryptokeys", force: :cascade do |t|
    t.integer  "domain_id",  limit: 4
    t.integer  "flags",      limit: 4
    t.boolean  "active"
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cryptokeys", ["domain_id"], name: "index_cryptokeys_on_domain_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "domainmetadata", force: :cascade do |t|
    t.integer  "domain_id",  limit: 4
    t.string   "kind",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domainmetadata", ["domain_id"], name: "index_domainmetadata_on_domain_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "master",          limit: 255
    t.integer  "last_check",      limit: 4
    t.string   "type",            limit: 255,   default: "NATIVE"
    t.integer  "notified_serial", limit: 4
    t.string   "account",         limit: 255
    t.integer  "ttl",             limit: 4,     default: 86400
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         limit: 4
    t.text     "notes",           limit: 65535
  end

  add_index "domains", ["name"], name: "index_domains_on_name", using: :btree

  create_table "macro_steps", force: :cascade do |t|
    t.integer  "macro_id",    limit: 4
    t.string   "action",      limit: 255
    t.string   "record_type", limit: 255
    t.string   "name",        limit: 255
    t.string   "content",     limit: 500
    t.integer  "ttl",         limit: 4
    t.integer  "prio",        limit: 4
    t.integer  "position",    limit: 4,                  null: false
    t.boolean  "active",                  default: true
    t.string   "note",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "macros", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "user_id",     limit: 4
    t.boolean  "active",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "record_templates", force: :cascade do |t|
    t.integer  "zone_template_id", limit: 4
    t.string   "name",             limit: 255
    t.string   "record_type",      limit: 255, null: false
    t.string   "content",          limit: 500, null: false
    t.integer  "ttl",              limit: 4,   null: false
    t.integer  "prio",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: :cascade do |t|
    t.integer  "domain_id",   limit: 4,                   null: false
    t.string   "name",        limit: 255,                 null: false
    t.string   "type",        limit: 255,                 null: false
    t.string   "content",     limit: 500,                 null: false
    t.integer  "ttl",         limit: 4,                   null: false
    t.integer  "prio",        limit: 4
    t.integer  "change_date", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",                default: false
    t.boolean  "auth",                    default: true
    t.string   "ordername",   limit: 255
  end

  add_index "records", ["domain_id", "ordername"], name: "index_records_on_domain_id_and_ordername", using: :btree
  add_index "records", ["domain_id"], name: "index_records_on_domain_id", using: :btree
  add_index "records", ["name", "type"], name: "index_records_on_name_and_type", using: :btree
  add_index "records", ["name"], name: "index_records_on_name", using: :btree

  create_table "supermasters", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.string   "nameserver", limit: 255
    t.string   "account",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tsigkeys", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "algorithm",  limit: 255
    t.string   "secret",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tsigkeys", ["name", "algorithm"], name: "index_tsigkeys_on_name_and_algorithm", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",                     limit: 255
    t.string   "email",                     limit: 255
    t.string   "encrypted_password",        limit: 128, default: "",        null: false
    t.string   "password_salt",             limit: 255, default: "",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 255
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token",        limit: 255
    t.datetime "confirmed_at"
    t.string   "state",                     limit: 255, default: "passive"
    t.datetime "deleted_at"
    t.boolean  "admin",                                 default: false
    t.boolean  "auth_tokens",                           default: false
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token",      limit: 255
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
  end

  create_table "zone_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "ttl",        limit: 4,   default: 86400
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.string   "type",       limit: 255, default: "NATIVE"
    t.string   "master",     limit: 255
  end

end
