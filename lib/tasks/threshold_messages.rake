namespace :threshold_messages do
	task :message => :environment do
		p "<><><><><><><><><><><><><><><><><>"
		# gather assets where high or low is available
		assets = Asset.all.where("high IS NOT NULL OR low IS NOT NULL")
		count = 0
		assets.each do |asset|
			unless asset.stock.nil?
				symbol = asset.stock.symbol
				price = asset.stock.last_trade_price_only
				trade_time = asset.stock.last_trade_time
				trade_date = asset.stock.last_trade_date.strftime '%m/%d/%Y'
				to_message = false

				if !asset.high.nil?
					if asset.high >= price
						byebug
						to_message = true
					end
				end
				if !asset.low.nil? and !to_message
					if asset.low <= price
						to_message = true
					end
				end

				if to_message
					message_body = "Symbol: #{symbol}\nLast Trade Price: #{price}\n #{trade_time} on #{trade_date}"

					count += send_message asset.user.phone, message_body, asset
					
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
		return 1
	rescue
		asset.sent_at = DateTime.now
		asset.previous_success = false
		return 0
	end
end