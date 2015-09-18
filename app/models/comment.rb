class Comment < ActiveRecord::Base
	validates :content,  presence: true, length: { minimum: 1 }
end
