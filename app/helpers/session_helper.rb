module SessionHelper
	def log_in(user)
		session[:user_id] = user.id
	end
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end
	def logged_in?
		!current_user.nil?
	end
	def forget(user)
    	user.forget
    	cookies.delete(:user_id)
    	cookies.delete(:remember_token)
  	end

	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	def timestamp created_at
  		t = ((Time.now - created_at.to_datetime))
  		if t < 60
  			t = pluralize((t).ceil, "second")
  		elsif t >= 60 and t < 60*60 
  			t = pluralize((t/60).ceil, "minute")
  		elsif t >= 60*60 and t < 24*60*60
  			t = pluralize((t/(60*60)).ceil, "hour")
  		elsif t>=24*60*60 and t < 30*24*60*60
  			t = pluralize((t/(24*60*60)).ceil, "day")
  		elsif t>= 30*24*60*60 and t < 365*24*30*60*60
  			t = pluralize((t/(30*24*60*60)).ceil, "month")
  		else
  			t = pluralize((t/(365*24*30*60*60)).ceil, "year")
  		end
  	end
  	def caption(caption)
  		hash_tag_pattern = /#(?<tag>[^#\s]+)/i
  		tags = caption.scan(hash_tag_pattern)
  		tags.each do |t|
  			link = "<a href='/explore?tag=#{t[0]}'>##{t[0]} </a>".html_safe
  			caption = caption.gsub("##{t[0]}",link)
  		end
  		caption.html_safe
  	end
  	def tag_search tag
		post_ids = HashTag.where("tag LIKE ?", tag).pluck(:post_id)
		posts = []
		post_ids.each do |i|
			posts << Post.find(i)
		end
		posts
	end
end
