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

ActiveRecord::Schema.define(version: 20130602124308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avirons", force: true do |t|
    t.string   "description"
    t.integer  "nbplaces"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creneaus", force: true do |t|
    t.time     "debut"
    t.time     "fin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rameurs", force: true do |t|
    t.string   "nom"
    t.string   "prenom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "rameurs", ["email"], name: "index_rameurs_on_email", unique: true
  add_index "rameurs", ["remember_token"], name: "index_rameurs_on_remember_token"
  add_index "rameurs", ["reset_password_token"], name: "index_rameurs_on_reset_password_token", unique: true

  create_table "registres", force: true do |t|
    t.integer  "rameur_id"
    t.integer  "reservation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registres", ["rameur_id"], name: "index_registres_on_rameur_id"
  add_index "registres", ["reservation_id"], name: "index_registres_on_reservation_id"

  create_table "reservations", force: true do |t|
    t.date     "jour"
    t.integer  "creneau_id"
    t.integer  "aviron_id"
    t.boolean  "confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "responsable_id"
  end

  add_index "reservations", ["aviron_id"], name: "index_reservations_on_aviron_id"
  add_index "reservations", ["creneau_id"], name: "index_reservations_on_creneau_id"
  add_index "reservations", ["responsable_id"], name: "index_reservations_on_responsable_id"

end
