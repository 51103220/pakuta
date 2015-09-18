class SessionController < ApplicationController
	def new
	end
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to controller: "home_page", action: "home" 
		else
			flash.now[:danger] = 'Invalid email or password'
			render 'new'
		end
	end
	def destroy
		log_out
		redirect_to root_url
	end
end
