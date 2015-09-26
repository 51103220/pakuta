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
  		t = ((Time.now - created_at.to_datetime)/3600)
  		if t < 1
  			t = (t*60).ceil.to_s + " minutes ago"
  		elsif t.floor == 1
  			t = t.floor.to_s + " hour ago"
  		else
  			t = t.floor.to_s + " hours ago"
  		end
  	end
end
