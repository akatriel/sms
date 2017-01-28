class StocksController < ApplicationController
	def create
		@user = current_user
		ticker = params[:ticker].upcase

		splitTicker = tidy_ticker(ticker).split(',')
		
		up_to_date = false
		couldnt_find_stocks = []
		found_stocks = []
		has_stock = false

		# need to store each ticker that we cant find into separate object	
		# to list in error 
		splitTicker.each do | ticker |
			stock = Stock.where(symbol: ticker).order(updated_at: :desc)
			
			has_stock = false

			if stock.exists?
				has_stock = true

				stock = stock.first
				# #######################################
				# if the latestPriceDate is older than the previous market date then update from api
				# TODO add holidays to db
				# #######################################
				# if is_within_market_hours and (1.hour.ago <=> stock.updated_at) >= 0

					# If we are inside market hours and the stock hasnt been updated in the db recently (1hr) we need to update model
					# old_stock = stock
					# new_stock = StockQuote::Stock.quote tidy_ticker(ticker)

					#  updates every single stock of that user that is out of date with the data returned from the most recent quote
					# @user.stocks.update hashify_stock(stock)
					
					# add asset if none exists
					# old_stock.update hashify_stock new_stock
				# end
				# if we get here then the stock is already in the db and up to date we just need to link it as an asset for the user

				# check for existing asset between stock and user if not create
				unless Asset.where(user_id:@user.id, stock_id: stock.id).exists?

					Asset.create(user_id: @user.id, stock_id: stock.id)
					found_stocks << stock.symbol
				end
			else
				stocks = StockQuote::Stock.quote tidy_ticker(ticker)

				# if 0 are returned
				if stocks.response_code == 404

				has_stock = false
				couldnt_find_stocks << ticker
				# if only 1 is returned
				elsif stocks.class == StockQuote::Stock

					@user.stocks.create hashify_stock(stocks)
					has_stock = true
					found_stocks << stocks.symbol
				# if multiple are returned
				else
					stocks.each do |stock|
						if stock.success?

							@user.stocks.create hashify_stock(stock)
							found_stocks << stock.symbol
						else

						end		
					end	
					has_stock = true
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

		# if is_within_market_hours and (1.hour.ago <=> @stock.updated_at) >= 0

			# If we are inside market hours and the stock hasnt been updated in the db recently (1hr) we need to update model
			
			new_stock = StockQuote::Stock.quote @stock.symbol
			#  updates every single stock of that user that is out of date with the data returned from the most recent quote
			# @user.stocks.update hashify_stock(stock)
			
			# add asset if none exists
			@stock.update hashify_stock new_stock
		# end

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
	def get_stock

	end

	def tidy_ticker ticker 
		ticker.split(',').map{|s| s.strip }.join(',')
	end

	def is_within_market_hours
		# may eventually need to abstract this to handle markets  in different time zones

		local_time = Time.now.in_time_zone "Eastern Time (US & Canada)"
		# between 10am and 4 pm EST and during a weekday
		if local_time.hour >= 10 and local_time.hour <= 16 and local_time.wday >= 1 and local_time.wday <= 5
			true
		else 
			false
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
		last_trade_date:stock.last_trade_date,
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
end
