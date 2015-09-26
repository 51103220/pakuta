class PostController < ApplicationController
	def create
		uploaded_io = params[:img_url]
		if uploaded_io.nil?
			flash[:success] = "Please upload your photos"
	    	redirect_to controller: "home_page", action: "home"
	    else
	    	if logged_in?
	    		user = current_user
	    		img_url = user.name.downcase + '_photo_' + uploaded_io.original_filename
					File.open(Rails.root.join('public', 'uploads', img_url), 'wb') do |file|
						file.write(uploaded_io.read)
					end
				post = Post.new
				post.user_id = user.id
				post.caption = params[:caption]
				post.img_url = "/uploads/" + img_url
				if post.save
					hash_tag_pattern = /#(?<tag>[^#]+)/i
					tags = post.caption.scan(hash_tag_pattern)
					tags.each do |t|
						ht = HashTag.new
						ht.post_id = post.id
						ht.tag = t
						if !ht.save
							flash[:success] = "Please use beautiful hash tags"
	    					redirect_to controller: "home_page", action: "home"
						end
						ht.save
					end
					flash[:success] = "Uploads done !!!"
	    			redirect_to controller: "home_page", action: "home"
				else
					flash[:success] = "Error"
	    			redirect_to controller: "home_page", action: "home"
				end
	    	else 
	    		flash[:success] = "Something is wrong with the upload, we wont tell you what it exactly is"
	    		redirect_to controller: "home_page", action: "home" 
	    	end
	    end
	end
end
