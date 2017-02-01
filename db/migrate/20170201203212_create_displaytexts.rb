class CreateDisplaytexts < ActiveRecord::Migration[5.0]
  def change
    create_table :displaytexts do |t|
    	t.integer :payload_id
      	t.string :ask_display_text
		t.string :average_daily_volume_display_text
		t.string :bid_display_text
		t.string :book_value_display_text
		t.string :change_display_text
		t.string :change_from_fiftyday_moving_average_display_text
		t.string :change_from_two_hundredday_moving_average_display_text
		t.string :change_from_year_high_display_text
		t.string :change_from_year_low_display_text
		t.string :change_percent_change_display_text
		t.string :changein_percent_display_text
		t.string :currency_display_text
		t.string :days_high_display_text
		t.string :days_low_display_text
		t.string :days_range_display_text
		t.string :dividend_pay_date_display_text
		t.string :dividend_share_display_text
		t.string :dividend_yield_display_text
		t.string :earnings_share_display_text
		t.string :ebitda_display_text
		t.string :eps_estimate_current_year_display_text
		t.string :eps_estimate_next_quarter_display_text
		t.string :eps_estimate_next_year_display_text
		t.string :ex_dividend_date_display_text
		t.string :fiftyday_moving_average_display_text
		t.string :last_trade_date_display_text
		t.string :last_trade_price_only_display_text
		t.string :last_trade_time_display_text
		t.string :last_trade_with_time_display_text
		t.string :market_capitalization_display_text
		t.string :name_display_text
		t.string :oneyr_target_price_display_text
		t.string :open_display_text
		t.string :pe_ratio_display_text
		t.string :peg_ratio_display_text
		t.string :percebt_change_from_year_high_display_text
		t.string :percent_change_display_text
		t.string :percent_change_from_fiftyday_moving_average_display_text
		t.string :percent_change_from_two_hundredday_moving_average_display_text
		t.string :percent_change_from_year_low_display_text
		t.string :previous_close_display_text
		t.string :price_book_display_text
		t.string :price_eps_estimate_current_year_display_text
		t.string :price_eps_estimate_next_year_display_text
		t.string :price_sales_display_text
		t.string :response_code_display_text
		t.string :short_ratio_display_text
		t.string :stock_exchange_display_text
		t.string :symbol_display_text
		t.string :two_hundredday_moving_average_display_text
		t.string :volume_display_text
		t.string :year_high_display_text
		t.string :year_low_display_text
		t.string :year_range_display_text
		t.timestamps
    end
  end
end
