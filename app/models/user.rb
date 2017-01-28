class User < ApplicationRecord
	has_many :assets
	has_many :stocks, through: :assets

	before_save   :downcase_email

	validates :phone, phone: true, uniqueness:true
	# Phonelib.valid_for_country? '123456789', 'XX'   # checks if passed value is valid number for specified country
	validates :username, presence: true, length: {minimum: 3}, uniqueness: true
	validates :password, length: {in: 6..20}, confirmation: true

	has_secure_password

	private
	# Converts email to all lower-case.
	def downcase_email
		self.email = email.downcase
	end
end
