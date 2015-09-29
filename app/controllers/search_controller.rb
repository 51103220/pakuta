class SearchController < ApplicationController
	def search 
		@tag = params[:tag]
		@posts = tag_search params[:tag]
	end
end
