class Payload < ApplicationRecord
	belongs_to :asset

	before_create :default_payload
	
	def default_payload
        self.avg_total_volume = false
        self.calculation_price = false
        self.change = false
        self.change_percent = false
        self.close = false
        self.close_time = false
        self.company_name = false
        self.delayed_price = false
        self.delayed_price_time = false
        self.high = false
        self.iex_ask_price = false
        self.iex_ask_size = false
        self.iex_bid_price = false
        self.iex_bid_size = false
        self.iex_last_updated = false
        self.iex_market_percent = false
        self.iex_realtime_price = false
        self.iex_realtime_size = false
        self.iex_volume = false
        self.latest_price = false
        self.latest_source = false
        self.latest_time = false
        self.latest_update = false
        self.latest_volume = false
        self.low = false
        self.market_cap = false
        self.open = false
        self.open_time = false
        self.pe_ratio = false
        self.previous_close = false
        self.primary_exchange = false
        self.response_code = false
        self.sector = false
        self.symbol = false
        self.week52_high = false
        self.week52_low = false
        self.ytd_change = false
	end
end