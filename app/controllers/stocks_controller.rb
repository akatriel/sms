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
			# Because Motley Fool contains ETF data
			# and is more reliable
			# Start with Fool, add to portfolio if there's a response
			fools_response = clean_fool_payload ticker

			if fools_response
				# add error handling
				# this Stock model doesn't have previous days data and volume
				@user.stocks.create(
					symbol: ticker,
					company: fools_response[:companyName],
					exchange: fools_response[:exchange],
					marketCap: fools_response[:marketCap],
					latestPrice: fools_response[:latestPrice],
					latestDate: fools_response[:latestPriceDate]
					# updated_at is automatically filled
				)

				up_to_date = true
				has_stock = true
			else 
				flash[:alert] = "There was an error getting data on that security."
			end
		end

		@stocks = @user.stocks
		# ^^ needed for create.js.erb

		respond_to do |format|
			if up_to_date and has_stock
				format.js
				format.html { 
					redirect_to user_path(@user), 
					notice: "#{stock.symbol} has been added to your portfolio!"
				}
			else
				# flash.now[:alert] = "We could not add that stock to your portfolio."
				format.html{redirect_to user_path(@user), flash:{
						alert: "We could not add that stock to your portfolio."}} and return
			end
		end
	end

	def show
		
	end

	def destroy
		@stock = Stock.find params[:id]
		@stock.destroy

		respond_to do |format|
			format.js
		end
	end

	private

	def clean_wiki_payload ticker
		#API query
		dataset = Stock.get_wiki ticker

		# returns false if cant find
		if dataset != false
			return {
				previousOpenDate: dataset.date,
				previousOpen: dataset.open,
				previousClose: dataset.close,
				previousHigh: dataset.high,
				previousLow:dataset.low,
				volume: dataset.volume
			}
		else
			return false
		end
	end

	def clean_fool_payload ticker
		dataset = Stock.get_fool ticker
		if dataset == false
			return false
		end
		
		dataset = dataset["TickerList"]["Ticker"]

		if dataset.key? "Error"
			return false
		end

		exchange = dataset["Exchange"]
		marketCap = dataset["MarketCap"].first unless dataset["MarketCap"].nil?
		latestPrice = dataset["LatestPrice"]
		latestPriceDate = dataset["LatestPriceDate"]
		companyName = dataset["CompanyName"]

		return {
			exchange: exchange,
			marketCap: marketCap,
			latestPriceDate: latestPriceDate,
			latestPrice: latestPrice,
			companyName: companyName
		}


		# pry(main)> response["TickerList"]["TimeStamp"]
		# => "2017-01-21 22:31:10" #weird because it was called at 17:31
		# response["TickerList"].keys
		# => ["Ticker", "Time", "TimeStamp", "Type", "Limit"]

		# pry(main)> response["TickerList"]["Ticker"].keys
		# ["Industry",
		# "MarketCap",
		# "Sector",
		# "Style",
		# "User",
		# "Symbol",
		# "Exchange",
		# "CompanyName",
		# "Percentile",
		# "Day30Return",
		# "LatestPriceDate",
		# "LatestPrice",
		# "PERatio",
		# "AllCompletedPicks",
		# "AllActivePicks",
		# "AllOutPicks",
		# "AllUnderPicks",
		# "ASActivePicks",
		# "ASOutPicks",
		# "ASUnderPicks",
		# "VPActivePicks",
		# "VPOutPicks",
		# "VPUnderPicks",
	 	# "PitchCount"]
	end
end
