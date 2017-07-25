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

ActiveRecord::Schema.define(version: 20170718002109) do

  create_table "entity_identifier_tags", force: :cascade do |t|
    t.integer  "entity_identifier_id"
    t.integer  "tag_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "entity_identifier_tags", ["entity_identifier_id"], name: "index_entity_identifier_tags_on_entity_identifier_id"
  add_index "entity_identifier_tags", ["tag_id"], name: "index_entity_identifier_tags_on_tag_id"

  create_table "entity_identifiers", force: :cascade do |t|
    t.string   "entity_id"
    t.integer  "entity_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "entity_identifiers", ["entity_type_id"], name: "index_entity_identifiers_on_entity_type_id"

  create_table "entity_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
