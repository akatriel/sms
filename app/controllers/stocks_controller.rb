class StocksController < ApplicationController
	def create
		@user = current_user
		ticker = params[:ticker].upcase


		stock = @user.stocks.where(symbol: ticker).order(updated_at: :desc)

		up_to_date = false
		has_stock = false

		if stock.exists?
			has_stock = true

			stock = stock.first
			# #######################################
			# if the latestPriceDate is older than the previous market date then update from api
			# TODO refactor check for upToDate?
			# TODO consider weekends and holidays
			if stock.latestDate.nil? || stock.latestDate >= Date.yesterday
				# need to update model
				fools_response = clean_fool_payload ticker

				if fools_response
					stock.update(
						symbol: ticker,
						company: fools_response[:companyName],
						exchange: fools_response[:exchange],
						marketCap: fools_response[:marketCap].first,
						latestPrice: fools_response[:latestPrice],
						latestDate: fools_response[:latestPriceDate]
					)
					up_to_date = true
					flash.now[:notice] = "#{ticker} was updated"
				end
			end
			flash.now[:notice] = "#{ticker} was already in your portfolio"
		else

			stocks = StockQuote::Stock.quote tidy_ticker(ticker)

			if stocks.class == StockQuote::Stock
				@user.stocks.create(
					ask:stocks.ask,
					average_daily_volume:stocks.average_daily_volume,
					bid:stocks.bid,
					book_value:stocks.book_value,
					change:stocks.change,
					change_from_fiftyday_moving_average:stocks.change_from_fiftyday_moving_average,
					change_from_two_hundredday_moving_average:stocks.change_from_two_hundredday_moving_average,
					change_from_year_high:stocks.change_from_year_high,
					change_from_year_low:stocks.change_from_year_low,
					change_percent_change:stocks.change_percent_change,
					changein_percent:stocks.changein_percent,
					# currency:stocks.currency,
					days_high:stocks.days_high,
					days_low:stocks.days_low,
					days_range:stocks.days_range,
					dividend_pay_date:stocks.dividend_pay_date,
					dividend_share:stocks.dividend_share,
					dividend_yield:stocks.dividend_yield,
					earnings_share:stocks.earnings_share,
					ebitda:stocks.ebitda,
					eps_estimate_current_year:stocks.eps_estimate_current_year,
					eps_estimate_next_quarter:stocks.eps_estimate_next_quarter,
					eps_estimate_next_year:stocks.eps_estimate_next_year,
					ex_dividend_date:stocks.ex_dividend_date,
					fiftyday_moving_average:stocks.fiftyday_moving_average,
					last_trade_date:stocks.last_trade_date,
					last_trade_price_only:stocks.last_trade_price_only,
					last_trade_time:stocks.last_trade_time,
					last_trade_with_time:stocks.last_trade_with_time,
					market_capitalization:stocks.market_capitalization,
					name:stocks.name,
					oneyr_target_price:stocks.oneyr_target_price,
					open:stocks.open,
					pe_ratio:stocks.pe_ratio,
					peg_ratio:stocks.peg_ratio,
					percebt_change_from_year_high:stocks.percebt_change_from_year_high,
					percent_change:stocks.percent_change,
					percent_change_from_fiftyday_moving_average:stocks.percent_change_from_fiftyday_moving_average,
					# percent_change_from_two_hundredday_moving_a:stocks.percent_change_from_two_hundredday_moving_a,
					percent_change_from_year_low:stocks.percent_change_from_year_low,
					previous_close:stocks.previous_close,
					price_book:stocks.price_book,
					price_eps_estimate_current_year:stocks.price_eps_estimate_current_year,
					price_eps_estimate_next_year:stocks.price_eps_estimate_next_year,
					price_sales:stocks.price_sales,
					response_code:stocks.response_code,
					short_ratio:stocks.short_ratio,
					stock_exchange:stocks.stock_exchange,
					symbol:stocks.symbol,
					two_hundredday_moving_average:stocks.two_hundredday_moving_average,
					volume:stocks.volume,
					year_high:stocks.year_high,
					year_low:stocks.year_low,
					year_range:stocks.year_range
				)
			else
				stocks.each do |stock|
					if stock.success?
						@user.stocks.create(
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
						)
					end		
				end	
			end
		end

		@stocks = @user.stocks
		# ^^ needed for create.js.erb

		respond_to do |format|
			if up_to_date and has_stock
				format.js
				format.html { 
					redirect_to user_path(@user)
				}
			else
				# flash.now[:alert] = "We could not add that stock to your portfolio."
				format.html{redirect_to user_path(@user), flash:{
						alert: "We could not add that stock to your portfolio."}} and return
			end
		end
	end

	def show
		@stock = Stock.find params[:id]
	end

	def destroy
		@stock = Stock.find params[:id]
		@stock.destroy

		respond_to do |format|
			format.js
		end
	end

	private 

	def tidy_ticker ticker 
		ticker.split(',').map{|s| s.strip }.join(',')
	end
end
