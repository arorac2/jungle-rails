class SessionsController < ApplicationController
    # Handles account login
    def new
    end
    helper_method :current_user
   

    def create
        user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
        if user
        #   log_in user
          cookies[:email] = {
            :value => user.email,
            :expires => 1.year.from_now
          }
          redirect_to root_path, notice: 'Logged in successfully!'
        else
          flash.now[:alert] = 'Invalid email or password'
          render 'new'
        end
      end
    
      def destroy
        # log_out
        cookies.delete(:email)
        # redirect_back(fallback_location: root_path)
        redirect_to root_path, notice: 'Logged out successfully!'
      end
    end