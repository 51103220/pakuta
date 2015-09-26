class CommentController < ApplicationController
	def create
		if params[:content].empty?
			flash[:success] = "Please fill the comment"
	    	redirect_to controller: "home_page", action: "home"
	    else
	    	if logged_in?
	    		user = current_user
	    		@avatar = user.avatar_url
	    		@name = user.name
	    		@comment = Comment.new
	    		@comment.user_id = user.id
	    		@comment.post_id = params[:post_id]
	    		@comment.content = params[:content]
	    		if @comment.save
	    			respond_to do |format|
  						format.js
					end
	    		else
	    			flash[:success] = "Error and we wont tell you "
	    			redirect_to controller: "home_page", action: "home"
	    		end
	    	else
	    		flash[:success] = "Please Login to comment"
	    		redirect_to controller: "home_page", action: "home"
	    	end
		end
	end
end
