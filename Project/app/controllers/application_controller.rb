class ApplicationController < ActionController::Base
    def destroy
        sign_out(current_user) # This method is provided by Devise
        redirect_to root_path, notice: 'You have been successfully signed out.'
      end
      before_action :configure_permitted_parameters, if: :devise_controller?

      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username])
      end
end
