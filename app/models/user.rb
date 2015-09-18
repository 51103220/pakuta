class User < ActiveRecord::Base
	attr_accessor :remember_token
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
	
	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end	
    def User.new_token
    	SecureRandom.urlsafe_base64
    end

    def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
  	end
  	def authenticated?(remember_token)
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
	def forget
    	update_attribute(:remember_digest, nil)
 	end

end
