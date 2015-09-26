class Post < ActiveRecord::Base
	belongs_to :user
	validates :img_url,  presence: true
	def poster user_id
		user = User.find(user_id)
	end
	def comments post_id
		comments = Comment.order(created_at: :desc).where(post_id: post_id)
	end
end	
