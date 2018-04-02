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

ActiveRecord::Schema.define(version: 20170201203212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "high"
    t.float "low"
    t.datetime "sent_at"
    t.boolean "previous_success"
    t.datetime "start_time"
    t.datetime "finish_time"
  end

  create_table "displaytexts", id: :serial, force: :cascade do |t|
    t.integer "payload_id"
    t.integer "avg_total_volume"
    t.string "calculation_price"
    t.decimal "change"
    t.decimal "change_percent"
    t.decimal "close"
    t.datetime "close_time"
    t.string "company_name"
    t.decimal "delayed_price"
    t.datetime "delayed_price_time"
    t.decimal "high"
    t.decimal "iex_ask_price"
    t.integer "iex_ask_size"
    t.decimal "iex_bid_price"
    t.integer "iex_bid_size"
    t.datetime "iex_last_updated"
    t.decimal "iex_market_percent"
    t.decimal "iex_realtime_price"
    t.integer "iex_realtime_size"
    t.bigint "iex_volume"
    t.decimal "latest_price"
    t.string "latest_source"
    t.datetime "latest_time"
    t.datetime "latest_update"
    t.bigint "latest_volume"
    t.decimal "low"
    t.bigint "market_cap"
    t.decimal "open"
    t.datetime "open_time"
    t.decimal "pe_ratio"
    t.decimal "previous_close"
    t.string "primary_exchange"
    t.integer "response_code"
    t.string "sector"
    t.string "symbol"
    t.decimal "week52_high"
    t.decimal "week52_low"
    t.decimal "ytd_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payloads", id: :serial, force: :cascade do |t|
    t.integer "asset_id"
    t.integer "avg_total_volume"
    t.string "calculation_price"
    t.decimal "change"
    t.decimal "change_percent"
    t.decimal "close"
    t.datetime "close_time"
    t.string "company_name"
    t.decimal "delayed_price"
    t.datetime "delayed_price_time"
    t.decimal "high"
    t.decimal "iex_ask_price"
    t.integer "iex_ask_size"
    t.decimal "iex_bid_price"
    t.integer "iex_bid_size"
    t.datetime "iex_last_updated"
    t.decimal "iex_market_percent"
    t.decimal "iex_realtime_price"
    t.integer "iex_realtime_size"
    t.bigint "iex_volume"
    t.decimal "latest_price"
    t.string "latest_source"
    t.datetime "latest_time"
    t.datetime "latest_update"
    t.bigint "latest_volume"
    t.decimal "low"
    t.bigint "market_cap"
    t.decimal "open"
    t.datetime "open_time"
    t.decimal "pe_ratio"
    t.decimal "previous_close"
    t.string "primary_exchange"
    t.integer "response_code"
    t.string "sector"
    t.string "symbol"
    t.decimal "week52_high"
    t.decimal "week52_low"
    t.decimal "ytd_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", id: :serial, force: :cascade do |t|
    t.integer "avg_total_volume"
    t.string "calculation_price"
    t.decimal "change"
    t.decimal "change_percent"
    t.decimal "close"
    t.datetime "close_time"
    t.string "company_name"
    t.decimal "delayed_price"
    t.datetime "delayed_price_time"
    t.decimal "high"
    t.decimal "iex_ask_price"
    t.integer "iex_ask_size"
    t.decimal "iex_bid_price"
    t.integer "iex_bid_size"
    t.datetime "iex_last_updated"
    t.decimal "iex_market_percent"
    t.decimal "iex_realtime_price"
    t.integer "iex_realtime_size"
    t.bigint "iex_volume"
    t.decimal "latest_price"
    t.string "latest_source"
    t.datetime "latest_time"
    t.datetime "latest_update"
    t.bigint "latest_volume"
    t.decimal "low"
    t.bigint "market_cap"
    t.decimal "open"
    t.datetime "open_time"
    t.decimal "pe_ratio"
    t.decimal "previous_close"
    t.string "primary_exchange"
    t.integer "response_code"
    t.string "sector"
    t.string "symbol"
    t.decimal "week52_high"
    t.decimal "week52_low"
    t.decimal "ytd_change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
