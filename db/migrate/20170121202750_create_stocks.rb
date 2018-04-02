class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :avg_total_volume
      t.string :calculation_price
      t.decimal :change
      t.decimal :change_percent
      t.decimal :close
      t.datetime :close_time
      t.string :company_name
      t.decimal :delayed_price
      t.datetime :delayed_price_time
      t.decimal :high
      t.decimal :iex_ask_price
      t.integer :iex_ask_size
      t.decimal :iex_bid_price
      t.integer :iex_bid_size
      t.datetime :iex_last_updated
      t.decimal :iex_market_percent
      t.decimal :iex_realtime_price
      t.integer :iex_realtime_size
      t.integer :iex_volume, limit:8
      t.decimal :latest_price
      t.string :latest_source
      t.datetime :latest_time
      t.datetime :latest_update
      t.integer :latest_volume, limit:8
      t.decimal :low
      t.integer :market_cap, limit:8
      t.decimal :open
      t.datetime :open_time
      t.decimal :pe_ratio
      t.decimal :previous_close
      t.string :primary_exchange
      t.integer :response_code
      t.string :sector
      t.string :symbol
      t.decimal :week52_high
      t.decimal :week52_low
      t.decimal :ytd_change
      t.timestamps
    end
  end
end

