namespace :threshold_messages do
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

				price = a_stock.last_trade_price_only
				trade_time = a_stock.last_trade_time
				trade_date = a_stock.last_trade_date.strftime '%m/%d/%Y'

				to_message = false

				if !asset.start_time.nil? and !asset.finish_time.nil? and asset.start_time.in_time_zone('Eastern Time (US & Canada)') <= Time.now and asset.finish_time.in_time_zone('Eastern Time (US & Canada)') >= Time.now
					if !asset.high.nil?
						if asset.high <= price
							to_message = true
						end
					end
					if !asset.low.nil? and !to_message
						if asset.low >= price
							to_message = true
						end
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
							message_body = "\nSymbol: #{symbol}\nLast Trade Price: #{price}\n #{trade_time} on #{trade_date}"
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
								header = display_text[option + "_display_text"] << ": "
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

def send_message phone, body, asset
	account_sid = ENV["TWILIO_ACCOUNT_SID"]
	auth_token = ENV["TWILIO_AUTH_TOKEN"]
	client = Twilio::REST::Client.new account_sid, auth_token

	begin
		client.messages.create(
			from: '+17142036952',#provided by twilio
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
	ask:stock.ask,
	average_daily_volume:stock.average_daily_volume,
	bid:stock.bid,
	book_value:stock.book_value,
	change:stock.change,
	change_from_fiftyday_moving_average:stock.change_from_fiftyday_moving_average,
	change_from_two_hundredday_moving_average:stock.change_from_two_hundredday_moving_average,
	change_from_year_high:stock.change_from_year_high,
	change_from_year_low:stock.change_from_year_low,
	change_percent_change:stock.change_percent_change,
	changein_percent:stock.changein_percent,
	# currency:stock.currency,
	days_high:stock.days_high,
	days_low:stock.days_low,
	days_range:stock.days_range,
	dividend_pay_date:stock.dividend_pay_date,
	dividend_share:stock.dividend_share,
	dividend_yield:stock.dividend_yield,
	earnings_share:stock.earnings_share,
	ebitda:stock.ebitda,
	eps_estimate_current_year:stock.eps_estimate_current_year,
	eps_estimate_next_quarter:stock.eps_estimate_next_quarter,
	eps_estimate_next_year:stock.eps_estimate_next_year,
	ex_dividend_date:stock.ex_dividend_date,
	fiftyday_moving_average:stock.fiftyday_moving_average,
	last_trade_date: Date.strptime(stock.last_trade_date, "%m/%d/%Y"),
	last_trade_price_only:stock.last_trade_price_only,
	last_trade_time:stock.last_trade_time,
	last_trade_with_time:stock.last_trade_with_time,
	market_capitalization:stock.market_capitalization,
	name:stock.name,
	oneyr_target_price:stock.oneyr_target_price,
	open:stock.open,
	pe_ratio:stock.pe_ratio,
	peg_ratio:stock.peg_ratio,
	percebt_change_from_year_high:stock.percebt_change_from_year_high,
	percent_change:stock.percent_change,
	percent_change_from_fiftyday_moving_average:stock.percent_change_from_fiftyday_moving_average,
	# percent_change_from_two_hundredday_moving_a:stock.percent_change_from_two_hundredday_moving_a,
	percent_change_from_year_low:stock.percent_change_from_year_low,
	previous_close:stock.previous_close,
	price_book:stock.price_book,
	price_eps_estimate_current_year:stock.price_eps_estimate_current_year,
	price_eps_estimate_next_year:stock.price_eps_estimate_next_year,
	price_sales:stock.price_sales,
	response_code:stock.response_code,
	short_ratio:stock.short_ratio,
	stock_exchange:stock.stock_exchange,
	symbol:stock.symbol,
	two_hundredday_moving_average:stock.two_hundredday_moving_average,
	volume:stock.volume,
	year_high:stock.year_high,
	year_low:stock.year_low,
	year_range:stock.year_range
	}
	# .reject{|k,v| v.blank?}
end