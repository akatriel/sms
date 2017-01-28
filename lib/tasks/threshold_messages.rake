namespace :threshold_messages do
	task :gather_assets => :environment do
		p "<><><><><><><><><><><><><><><><><>"
		# gather assets where high or low is available
		assets = Asset.all.where("high IS NOT NULL OR low IS NOT NULL")
		to_message = []
		assets.each do |asset|
			symbol = asset.stock.symbol
			price = asset.stock.last_trade_price_only

			if !asset.high.nil?
				if asset.high >= price
					to_message << asset
					next
				end
			end
			if !asset.low.nil?
				if asset.low <= price
					to_message << asset
				end
			end

			StockQuote::Stock.quote
		end
		p "<><><><><><><><><><><><><><><><><>"
	end
end
