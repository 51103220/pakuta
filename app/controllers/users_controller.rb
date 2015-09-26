class UsersController < ApplicationController
	def show
		name = params[:name].downcase
		@user = User.find_by(name: name)
	end
	def new
		@user = User.new
	end
	def edit
		@user = User.find_by(name: params[:name])
	end
	def create
	    @user = User.new(user_params)    
	    if @user.save
	    	log_in @user
	    	flash[:success] = "Now You are a Pakuta !!!"
	    	redirect_to controller: "home_page", action: "home" 
	    else
	    	render 'new'
	    end
	end
	def update
		@user = User.find(params[:id])
		uploaded_io = params[:user][:avatar_url]
		if params[:user][:avatar_link] != ""
			@user.avatar_url = params[:user][:avatar_link]
		elsif uploaded_io.nil? == false
			img_url = @user.name.downcase + '_avatar_' + uploaded_io.original_filename
			File.open(Rails.root.join('public', 'uploads', img_url), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			@user.avatar_url = "/uploads/" + img_url
		end
		@user.name = params[:user][:name]
		@user.real_name = params[:user][:real_name]	
		if @user.save
			flash[:success] = "Yeah updated !!!"
			redirect_to action: 'show', name: @user.name 
		else
			render 'edit'
		end
	end
	private

	def user_params
		params.require(:user).permit(:name, :email, :password,
			:password_confirmation)
	end
end
