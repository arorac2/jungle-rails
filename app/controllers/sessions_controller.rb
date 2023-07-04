class SessionsController < ApplicationController
    def new
    end
    helper_method :current_user

    def create
        user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
        if user
          log_in user
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