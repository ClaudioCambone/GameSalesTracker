class ApplicationController < ActionController::Base
    def destroy
        sign_out(current_user) # This method is provided by Devise
        redirect_to root_path, notice: 'You have been successfully signed out.'
      end
end
