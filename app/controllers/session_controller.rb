class SessionController < ApplicationController
	def new
		@user = User.new
	end
	def create
		user = User.where(username: params[:username]).first
		if user && user.authenticate(params[:password])
			flash[:notice] = "Login Success"
			session[:user_id] = user.id
			redirect_to current_user
		else
			flash.now[:alert] = "There was a problem creating a session."
			render :new
		end
	end
	def destroy
		session.clear
		redirect_to '/login'
	end
end
