class HomePageController < ApplicationController
	def home
		@user
		if logged_in?
			@user = current_user
		end
		render :action => "home"
	end
end
