class CreatePayload < ActiveRecord::Migration[5.0]
  def change
    create_table :payloads do |t|
    	t.integer :asset_id
	    t.boolean :ask
		t.boolean :average_daily_volume
		t.boolean :bid
		t.boolean :book_value
		t.boolean :change
		t.boolean :change_from_fiftyday_moving_average
		t.boolean :change_from_two_hundredday_moving_average
		t.boolean :change_from_year_high
		t.boolean :change_from_year_low
		t.boolean :change_percent_change
		t.boolean :changein_percent
		t.boolean :currency
		t.boolean :days_high
		t.boolean :days_low
		t.boolean :days_range
		t.boolean :dividend_pay_date
		t.boolean :dividend_share
		t.boolean :dividend_yield
		t.boolean :earnings_share
		t.boolean :ebitda
		t.boolean :eps_estimate_current_year
		t.boolean :eps_estimate_next_quarter
		t.boolean :eps_estimate_next_year
		t.boolean :ex_dividend_date
		t.boolean :fiftyday_moving_average
		t.boolean :last_trade_date
		t.boolean :last_trade_price_only
		t.boolean :last_trade_time
		t.boolean :last_trade_with_time
		t.boolean :market_capitalization
		t.boolean :name
		t.boolean :oneyr_target_price
		t.boolean :open
		t.boolean :pe_ratio
		t.boolean :peg_ratio
		t.boolean :percebt_change_from_year_high
		t.boolean :percent_change
		t.boolean :percent_change_from_fiftyday_moving_average
		t.boolean :percent_change_from_two_hundredday_moving_average
		t.boolean :percent_change_from_year_low
		t.boolean :previous_close
		t.boolean :price_book
		t.boolean :price_eps_estimate_current_year
		t.boolean :price_eps_estimate_next_year
		t.boolean :price_sales
		t.boolean :response_code
		t.boolean :short_ratio
		t.boolean :stock_exchange
		t.boolean :symbol
		t.boolean :two_hundredday_moving_average
		t.boolean :volume
		t.boolean :year_high
		t.boolean :year_low
		t.boolean :year_range
    end
  end
end
		