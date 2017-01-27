class Stock < ApplicationRecord
	has_many :assets
	has_many :users, through: :assets
	
	# before_save :stock_updated_after_close

	# def stock_updated_after_close
	# 	self.last_trade_time
	# end
end	