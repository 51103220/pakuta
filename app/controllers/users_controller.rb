class UsersController < ApplicationController
	def show
		name = params[:name].downcase
		@user = User.find_by(name: name)
	end
	def new
		@user = User.new
	end
	def create
	    @user = User.new(user_params)    # Not the final implementation!
	    if @user.save
	    	log_in @user
	    	flash[:success] = "Now You are a Pakuta !!!"
	     	redirect_to controller: "home_page", action: "home" 
	    else
	      	render 'new'
	    end
 	end
 	private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end