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

ActiveRecord::Schema.define(version: 20140604012156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assumptions", force: true do |t|
    t.integer "proof_id"
    t.integer "trait_id"
  end

  add_index "assumptions", ["proof_id"], name: "assumptions_proofs_fk", using: :btree
  add_index "assumptions", ["trait_id"], name: "assumptions_traits_fk", using: :btree

  create_table "emails", force: true do |t|
    t.string  "email",   default: ""
    t.integer "user_id"
    t.string  "verkey",  default: ""
  end

  create_table "proofs", force: true do |t|
    t.integer  "trait_id"
    t.integer  "theorem_id"
    t.integer  "theorem_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "proofs", ["theorem_id"], name: "proofs_theorems_fk", using: :btree
  add_index "proofs", ["trait_id"], name: "proofs_traits_fk", using: :btree

  create_table "properties", force: true do |t|
    t.string   "name",         default: ""
    t.text     "description",  default: ""
    t.integer  "value_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["value_set_id"], name: "properties_value_sets_fk", using: :btree

  create_table "remote_users", force: true do |t|
    t.string  "ident",    default: ""
    t.string  "password", default: ""
    t.string  "name"
    t.boolean "admin",    default: false
  end

  add_index "remote_users", ["ident"], name: "index_remote_users_on_ident", using: :btree

  create_table "spaces", force: true do |t|
    t.string   "name",              default: ""
    t.text     "description",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "proof_of_topology"
  end

  create_table "supporters", force: true do |t|
    t.integer "assumed_id"
    t.integer "implied_id"
  end

  create_table "theorem_properties", force: true do |t|
    t.integer "theorem_id"
    t.integer "property_id"
  end

  add_index "theorem_properties", ["property_id"], name: "theorem_properties_properties_fk", using: :btree
  add_index "theorem_properties", ["theorem_id"], name: "theorem_properties_theorems_fk", using: :btree

  create_table "theorems", force: true do |t|
    t.text     "description", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "antecedent",  default: ""
    t.string   "consequent",  default: ""
  end

  create_table "traits", force: true do |t|
    t.integer  "space_id"
    t.integer  "property_id"
    t.integer  "value_id"
    t.text     "description", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deduced",     default: false
  end

  add_index "traits", ["property_id", "value_id"], name: "index_traits_on_property_id_and_value_id", using: :btree
  add_index "traits", ["space_id"], name: "index_traits_on_space_id", using: :btree
  add_index "traits", ["value_id"], name: "traits_values_fk", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                               default: ""
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "value_sets", force: true do |t|
    t.string   "name",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "values", force: true do |t|
    t.string   "name",         default: ""
    t.integer  "value_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "values", ["value_set_id"], name: "index_values_on_value_set_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
