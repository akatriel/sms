class User < ApplicationRecord
	has_many :assets
	has_many :stocks, through: :assets

	before_save   :downcase_email

	validates :phone, phone: true
	# Phonelib.valid_for_country? '123456789', 'XX'   # checks if passed value is valid number for specified country


	has_secure_password

	private
	# Converts email to all lower-case.
	def downcase_email
		self.email = email.downcase
	end
end
