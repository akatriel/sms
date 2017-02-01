class Asset < ApplicationRecord
	belongs_to :stock
	belongs_to :user
	has_one :payload

end
