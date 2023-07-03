class SessionsController < ApplicationController
    def new
    end
    helper_method :current_user

    def create
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        log_in (user)
        redirect_to root_path, notice: 'Logged in successfully!'
      else
        flash.now[:alert] = 'Invalid email or password'
        render 'new'
      end
    end
  
    def destroy
      log_out
      redirect_to root_path, notice: 'Logged out successfully!'
    end
end
