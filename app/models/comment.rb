class Comment < ActiveRecord::Base
	validates :content,  presence: true, length: { minimum: 1 }
	def commentator user_id
		user = User.find(user_id)
	end
end
