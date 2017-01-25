class Stock < ApplicationRecord
	has_many :assets
	has_many :users, through: :assets
end