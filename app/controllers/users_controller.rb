class UsersController < ApplicationController
  # Handles account sign up - when someone creates t
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        # log_in @user # this line set the cookies! call email
        cookies[:email] = {
          :value => user.email,
          :expires => 1.year.from_now
        }
        redirect_to root_path, notice: 'Account created successfully!'
      else
        render 'new'
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
  end