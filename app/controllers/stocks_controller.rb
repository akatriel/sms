class StocksController < ApplicationController
	def create
		@user = current_user

		ticker = params[:ticker].upcase

		stock = Stock.where(symbol: ticker).order(updated_at: :desc)

		if stock.exists?
			stock = stock.first
		else

		end
	end

	private

	def clean_wiki_payload ticker
		#API query
		dataset = Stock.get_wiki ticker

		# returns false if cant find
		if dataset != false
			return {
				symbol: ticker,
				date:dataset.date,
				open: dataset.open,
				close: dataset.close,
				high: dataset.high,
				low:dataset.low,
				volume: dataset.volume
			}
		else
			return false
		end
	end

	def clean_fool_payload ticker
		dataset = Stock.get_fool ticker
		dataset == false ? return false : dataset = dataset["TickerList"]["Ticker"]

		exchange = dataset["Exchange"]
		marketCap = dataset["MarketCap"]
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
