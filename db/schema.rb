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

ActiveRecord::Schema.define(version: 20170121202852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.float    "ask"
    t.float    "average_daily_volume"
    t.float    "bid"
    t.float    "book_value"
    t.float    "change"
    t.float    "change_from_fiftyday_moving_average"
    t.float    "change_from_two_hundredday_moving_average"
    t.float    "change_from_year_high"
    t.float    "change_from_year_low"
    t.string   "change_percent_change"
    t.string   "changein_percent"
    t.string   "currency"
    t.float    "days_high"
    t.float    "days_low"
    t.string   "days_range"
    t.datetime "dividend_pay_date"
    t.float    "dividend_share"
    t.float    "dividend_yield"
    t.float    "earnings_share"
    t.string   "ebitda"
    t.float    "eps_estimate_current_year"
    t.float    "eps_estimate_next_quarter"
    t.float    "eps_estimate_next_year"
    t.datetime "ex_dividend_date"
    t.float    "fiftyday_moving_average"
    t.datetime "last_trade_date"
    t.float    "last_trade_price_only"
    t.string   "last_trade_time"
    t.string   "last_trade_with_time"
    t.string   "market_capitalization"
    t.string   "name"
    t.float    "oneyr_target_price"
    t.float    "open"
    t.float    "pe_ratio"
    t.float    "peg_ratio"
    t.string   "percebt_change_from_year_high"
    t.string   "percent_change"
    t.string   "percent_change_from_fiftyday_moving_average"
    t.string   "percent_change_from_two_hundredday_moving_average"
    t.string   "percent_change_from_year_low"
    t.float    "previous_close"
    t.float    "price_book"
    t.float    "price_eps_estimate_current_year"
    t.float    "price_eps_estimate_next_year"
    t.float    "price_sales"
    t.integer  "response_code"
    t.float    "short_ratio"
    t.string   "stock_exchange"
    t.string   "symbol"
    t.float    "two_hundredday_moving_average"
    t.float    "volume"
    t.float    "year_high"
    t.float    "year_low"
    t.string   "year_range"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
