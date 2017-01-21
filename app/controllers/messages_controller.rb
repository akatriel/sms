class MessagesController < ApplicationController
	def create

		twilioInfo = []
		File.foreach('./secrets.text') {|x| twilioInfo << x}

		account_sid = twilioInfo[0].split(' ').last
		auth_token = twilioInfo[1].split(' ').last
		@client = Twilio::REST::Client.new account_sid, auth_token

		user = current_user
		portfolio = user.stocks


		body = []
		portfolio.each do |stock|
			stock_str = ""
			stock_str += "Symbol: #{stock.symbol}" + "\n Date: #{stock.date}" + "\n Open: #{stock.open}" + "\n Close: #{stock.close}" + "\n High: #{stock.high}" + "\n Low: #{stock.low}" + "\n Volume: #{stock.volume}"
			body.push(stock_str)
		end
		body = body.join("\n").html_safe
		p ">>>>>>>>>>>>>>>>>>>>>>>"
		p body


		begin
			@client.messages.create(
				from: '+17142036952',#provided by twilio
				to: "+1#{user.phone}",
				body: "#{body}"
			)
		rescue
			flash[:alert] = "There was an issue sending your message."
		ensure
			redirect_to user_path(current_user)
		end
	end
end
