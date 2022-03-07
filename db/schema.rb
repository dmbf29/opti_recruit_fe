# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_07_104916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level"
  end

  create_table "player_seasons", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "season_id", null: false
    t.integer "international_reputation"
    t.integer "release_cause_eur"
    t.integer "pace"
    t.integer "shooting"
    t.integer "passing"
    t.integer "dribbling"
    t.integer "defending"
    t.integer "physic"
    t.integer "attacking_crossing"
    t.integer "attacking_heading_accuracy"
    t.integer "attacking_short_passing"
    t.integer "skill_dribbling"
    t.integer "skill_fk_accuracy"
    t.integer "skill_long_passing"
    t.integer "skill_ball_control"
    t.integer "movement_acceleration"
    t.integer "movement_spring_speed"
    t.integer "power_shot_power"
    t.integer "power_jumping"
    t.integer "power_stamina"
    t.integer "power_strength"
    t.integer "power_long_shots"
    t.integer "defending_marking_awareness"
    t.integer "defending_standing_tackle"
    t.integer "defending_sliding_tackle"
    t.string "player_face_url"
    t.integer "heigh_cm"
    t.integer "weight_kg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "games"
    t.integer "minutes"
    t.integer "goals"
    t.integer "assists"
    t.integer "goals_pens"
    t.float "goals_per90"
    t.float "assists_per90"
    t.float "goals_pens_per90"
    t.float "xg"
    t.float "npxg"
    t.integer "xa"
    t.float "xg_per90"
    t.float "xa_per90"
    t.float "npxg_per90"
    t.integer "passes_completed"
    t.integer "passes"
    t.integer "passes_completed_short"
    t.integer "passes_short"
    t.integer "passes_completed_medium"
    t.integer "passes_medium"
    t.integer "passes_completed_long"
    t.integer "passes_long"
    t.integer "progressive_passes"
    t.integer "gca"
    t.integer "tackles"
    t.integer "dribble_tackles"
    t.integer "pressures"
    t.integer "blocks"
    t.integer "interceptions"
    t.integer "clearances"
    t.integer "touches_att_pen_area"
    t.integer "dribbles_completed"
    t.integer "progressive_carries"
    t.integer "progressive_passes_received"
    t.integer "crosses"
    t.integer "tackles_won"
    t.integer "aerials_won"
    t.integer "overall"
    t.integer "potential"
    t.integer "value_eur"
    t.integer "wage_eur"
    t.bigint "team_id", null: false
    t.index ["player_id"], name: "index_player_seasons_on_player_id"
    t.index ["season_id"], name: "index_player_seasons_on_season_id"
    t.index ["team_id"], name: "index_player_seasons_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "sofifa_id"
    t.string "player_url"
    t.date "dob"
    t.string "nationality_name"
    t.string "preferred_foot"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "short_name"
    t.string "long_name"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "club_logo_url"
    t.string "club_flag_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "league_id", null: false
    t.string "alternate_name"
    t.index ["league_id"], name: "index_teams_on_league_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "player_seasons", "players"
  add_foreign_key "player_seasons", "seasons"
  add_foreign_key "player_seasons", "teams"
  add_foreign_key "teams", "leagues"
end
