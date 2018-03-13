class UsersController < ApplicationController
	def show
		@user= User.find_by_id(params[:id])
	end 
	
	def update
		user= User.find_by_id(params[:id])
	    if(user.id == current_user.id)
	       user.update(user_params)
	       flash[:message] = 'updated successfully'
           redirect_to "/users/#{user.id}"	
		else
		   flash[:message] = 'you are not the user'
		    redirect_to "/users/#{user.id}"		
        end
    end    
 
	def new
	@user = User.new
	end

	def create
	user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    else 
      flash[:alert] = "Account Info Invalid. Please Try Again." 
    end
  end

  def destroy 
  	 @user = User.find(current_user.id)
    if @user.destroy
    redirect_to '/users/new'
  end

end
	
	private
    def user_params
    	params.require(:user).permit(:username, :password, :location, :name, :email, :faves, :bio,
:achievements)
    end 

end