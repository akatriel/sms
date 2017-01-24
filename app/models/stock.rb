class Stock < ApplicationRecord
	has_many :assets
	has_many :users, through: :assets



	def self.get_fool ticker
		ticker = ticker.upcase
		apikey = ENV["FOOL_KEY"]
		url = "http://www.fool.com/a/caps/ws/Ticker/#{ticker}?apikey=#{apikey}"
		# begin
			HTTParty.get url
		# rescue
			# return false
		# end
	end

	Quandl::ApiConfig.api_key = 'exAUgh8NLoYAjuwd22PH'
	Quandl::ApiConfig.api_version = '2015-04-09'
	# @database = Quandl::Database.get('WIKI')	

	def self.get_wiki ticker
		ticker = ticker.upcase
		begin
			query = Quandl::Dataset.get("WIKI/#{ticker.upcase}").data.first
			cloned = query.clone
			cloned
		rescue
			return false
		end
	end

	def self.get_from_yahoo ticker

	end
end
