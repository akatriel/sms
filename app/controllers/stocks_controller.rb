class StocksController < ApplicationController
	def create
		@user = current_user
		ticker = params[:ticker].upcase
		splitTicker = tidy_ticker(ticker).split(',')
		up_to_date = false
		couldnt_find_stocks = []
		found_stocks = []

		splitTicker.each do | ticker |
			dbstocks = Stock.where(symbol: ticker)
			if dbstocks.exists?
				dbstock = dbstocks.first
				# check db if stock - user connection is made if not add connection
				# this reduces the need to make multiple requests for a stock that's already
				# in the database for another user
				unless Asset.where(user_id:@user.id, stock_id: dbstock.id).exists?
					Asset.create(user_id: @user.id, stock_id: dbstock.id)
					found_stocks << dbstock.symbol
				end
			else
				stocks = StockQuote::Stock.quote tidy_ticker(ticker)

				if stocks.response_code == 404
					couldnt_find_stocks << ticker
				# if only 1 is returned
				elsif stocks.class == StockQuote::Stock
					@user.stocks.create hashify_stock(stocks)
			
					found_stocks << stocks.symbol
				# if multiple are returned
				else
					stocks.each do |stock|
						byebug
						if stock.success?
							@user.stocks.create hashify_stock(stock)
							found_stocks << stock.symbol
						end		
					end	
				end
			end
		end
		

		@stocks = @user.stocks
		# ^^ needed for create.js.erb

		respond_to do |format|
			if couldnt_find_stocks.size == 0
				flash.now[:notice] = found_stocks.join(', ') + " have been added to your profile"
			else
				flash.now[:alert] = couldnt_find_stocks.join(', ') + " couldn't be added"
			end

			format.html{render user_path(@user)}
			format.js
		end
	end

	def show
		@stock = Stock.find params[:id]
		@asset = @stock.assets.where(user_id: current_user.id, stock_id: @stock.id).first
		@payload = @asset.payload

		if @payload.nil?
			@payload = Payload.create(asset_id: @asset.id)
		end
		@displaytext = Displaytext.first

		begin
			new_stock = StockQuote::Stock.quote @stock.symbol

			@stock.update hashify_stock new_stock
		rescue
			flash[:alert] = "There was a problem getting info on that ticker"
			redirect_to user_path(current_user)
		end
	end



	def destroy
		@stock = Stock.find params[:id]
		asset = @stock.assets.where(stock_id: @stock.id, user_id: current_user.id).first
		flash.now[:alert] = "#{@stock.symbol} has been removed"
		asset.destroy

		respond_to do |format|
			format.js
		end
	end

	private

	def tidy_ticker ticker 
		ticker.split(',').map{|s| s.strip }.join(',')
	end

	# def is_within_market_hours
	# 	# may eventually need to abstract this to handle markets  in different time zones

	# 	local_time = Time.now.in_time_zone "Eastern Time (US & Canada)"
	# 	weekday = false
	# 	weekend = false
	# 	holiday = false
	# 	# between 10am and 4 pm EST and during a weekday
	# 	if local_time.hour >= 10 and local_time.hour <= 16 and local_time.wday >= 1 and local_time.wday <= 5
	# 		weekday = true
	# 	else 
	# 		weekend = true
	# 	end
	# end

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
end
