class HomePageController < ApplicationController
	def home
		render :action => "home"
	end
	def profile
		render :action => "profile"
	end
	def pakuta
		render :action => "pakuta"
	end
end
