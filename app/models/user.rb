class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_save { self.name = name.downcase }
	VALID_NAME_REGEX = /\A[a-zA-Z0-9_]+\z/i
	validates :name,  presence: true, length: { maximum: 20 },
			format: { with: VALID_NAME_REGEX }, uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 50 }, 
			format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	has_secure_password
end
