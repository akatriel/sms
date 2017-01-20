class User < ApplicationRecord
	before_save   :downcase_email
	
	# validates :phone, phone: true
	# Phonelib.valid_for_country? '123456789', 'XX'   # checks if passed value is valid number for specified country

	private
	# Converts email to all lower-case.
	def downcase_email
		self.email = email.downcase
	end
end
