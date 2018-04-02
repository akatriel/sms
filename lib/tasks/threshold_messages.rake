namespace :threshold_messages do
	desc "Builds messages for Twilio API"
	task :message => :environment do
		p "<><><><><><><><><><><><><><><><><>"
		# gather assets where high or low is available
		assets = Asset.all.where("high IS NOT NULL OR low IS NOT NULL")
		count = 0
		assets.each do |asset|
			unless asset.stock.nil?
				a_stock = asset.stock
				symbol = a_stock.symbol

				new_stock = StockQuote::Stock.quote symbol
				a_stock.update(hashify_stock new_stock)

				price = a_stock.latest_price
				trade_time = a_stock.latest_time
				#trade_date = a_stock.last_trade_date.strftime '%m/%d/%Y'

				to_message = false

				if asset_within_window? asset

					if !asset.high.nil?
						to_message = asset.high <= price
					end

					if !asset.low.nil? and !to_message
							to_message = asset.low >= price
					end	

					if to_message
						message_options = []
						if asset.payload.nil?
							pay = Payload.new
							pay.default_payload
							pay.asset_id = asset.id
							pay.save
						else
							asset.payload.attributes.each do |k, v| 
								message_options << k if v == true
							end
						end
						
						if message_options.size == 0
							message_body = "\nSymbol: #{symbol}\nLast Trade Price: #{price}\n #{trade_time}"
							message_body << "\nfinance.yahoo.com/quote/#{symbol}?p=#{symbol}"
						else 
							display_text = Displaytext.first
							if display_text.nil?
								display_text = Displaytext.new
								display_text.add_display_text
								display_text.save
							end 

							message_body = "Symbol: "  + symbol + "\n"
							message_options.each do |option|
								header = display_text[option] << ": "
								message_body += header << a_stock[option].to_s + "\n"
							end
					end
					count += send_message asset.user.phone, message_body, asset
				end
			end
		end
	end
		p "#{count} messages sent"
		p "<><><><><><><><><><><><><><><><><>"
	end
end

def asset_within_window? asset
	!asset.start_time.nil? and !asset.finish_time.nil? and asset.start_time.in_time_zone('Eastern Time (US & Canada)') <= Time.now and asset.finish_time.in_time_zone('Eastern Time (US & Canada)') >= Time.now
end

def send_message phone, body, asset
	account_sid = ENV["twilio_account_sid"]
	auth_token = ENV["twilio_auth_token"]
	client = Twilio::REST::Client.new account_sid, auth_token
	byebug
	begin
		client.messages.create(
			from: "+1#{ENV["twilio_number"]}",#provided by twilio
			to: "+1#{phone}",
			body: "#{body}".html_safe
		)
		asset.sent_at = DateTime.now
		asset.previous_success = true
		asset.save
		return 1
	rescue
		asset.sent_at = DateTime.now
		asset.previous_success = false
		asset.save
		return 0
	end
end

def hashify_stock stock
	return {
		avg_total_volume: stock.avg_total_volume,
		calculation_price: stock.calculation_price,
		change: stock.change,
		change_percent: stock.change_percent,
		close: stock.close,
		close_time: stock.close_time,
		company_name: stock.company_name,
		delayed_price: stock.delayed_price,
		delayed_price_time: stock.delayed_price_time,
		high: stock.high,
		iex_ask_price: stock.iex_ask_price,
		iex_ask_size: stock.iex_ask_size,
		iex_bid_price: stock.iex_bid_price,
		iex_bid_size: stock.iex_bid_size,
		iex_last_updated: stock.iex_last_updated,
		iex_market_percent: stock.iex_market_percent,
		iex_realtime_price: stock.iex_realtime_price,
		iex_realtime_size: stock.iex_realtime_size,
		iex_volume: stock.iex_volume,
		latest_price: stock.latest_price,
		latest_source: stock.latest_source,
		latest_time: stock.latest_time,
		latest_update: stock.latest_update,
		latest_volume: stock.latest_volume,
		low: stock.low,
		market_cap: stock.market_cap,
		open: stock.open,
		open_time: stock.open_time,
		pe_ratio: stock.pe_ratio,
		previous_close: stock.previous_close,
		primary_exchange: stock.primary_exchange,
		response_code: stock.response_code,
		sector: stock.sector,
		symbol: stock.symbol,
		week52_high: stock.week52_high,
		week52_low: stock.week52_low,
		ytd_change: stock.ytd_change
	}
	# .reject{|k,v| v.blank?}
end
