class Payload < ApplicationRecord
	belongs_to :asset

	before_create :default_payload

	def default_payload
		self.ask = false
		self.average_daily_volume = false
		self.bid = false
		self.book_value = false
		self.change = false
		self.change_from_fiftyday_moving_average = false
		self.change_from_two_hundredday_moving_average = false
		self.change_from_year_high = false
		self.change_from_year_low = false
		self.change_percent_change = false
		self.changein_percent = false
		self.currency = false
		self.days_high = false
		self.days_low = false
		self.days_range = false
		self.dividend_pay_date = false
		self.dividend_share = false
		self.dividend_yield = false
		self.earnings_share = false
		self.ebitda = false
		self.eps_estimate_current_year = false
		self.eps_estimate_next_quarter = false
		self.eps_estimate_next_year = false
		self.ex_dividend_date = false
		self.fiftyday_moving_average = false
		self.last_trade_date = false
		self.last_trade_price_only = false
		self.last_trade_time = false
		self.last_trade_with_time = false
		self.market_capitalization = false
		self.name = false
		self.oneyr_target_price = false
		self.open = false
		self.pe_ratio = false
		self.peg_ratio = false
		self.percebt_change_from_year_high = false
		self.percent_change = false
		self.percent_change_from_fiftyday_moving_average = false
		self.percent_change_from_two_hundredday_moving_average = false
		self.percent_change_from_year_low = false
		self.previous_close = false
		self.price_book = false
		self.price_eps_estimate_current_year = false
		self.price_eps_estimate_next_year = false
		self.price_sales = false
		self.response_code = false
		self.short_ratio = false
		self.stock_exchange = false
		self.symbol = false
		self.two_hundredday_moving_average = false
		self.volume = false
		self.year_high = false
		self.year_low = false
		self.year_range = false
	end
end