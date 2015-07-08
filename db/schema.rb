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

ActiveRecord::Schema.define(version: 20150708150405) do

  create_table "boards", force: :cascade do |t|
    t.text     "board_state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "player_one"
    t.integer  "player_two"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "is_active"
    t.integer  "board_id"
    t.integer  "last_player_id"
    t.integer  "winner_id"
  end

  add_index "games", ["board_id"], name: "index_games_on_board_id"

  create_table "players", force: :cascade do |t|
    t.string   "token"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"

end
