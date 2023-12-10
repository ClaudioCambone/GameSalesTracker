class ApplicationController < ActionController::Base
  before_action :check_ban_status
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
    end
  
  private 
  
  def ban_expired?
    current_user.ban_until.present? && Time.current > current_user.ban_until
  end

  def check_ban_status
    if user_signed_in? && current_user.banned? && ban_expired?
      current_user.update(banned: false, ban_until: nil)
      flash[:notice] = 'Your temporary ban has expired. You can now sign in.'
    elsif user_signed_in? && current_user.banned?
      sign_out(current_user)
      flash[:alert] = 'Your account has been banned. Please contact support for assistance.'
      redirect_to root_path
    end
  end


  helper ApplicationHelper
    def destroy
        sign_out(current_user) # This method is provided by Devise
        redirect_to root_path, notice: 'You have been successfully signed out.'
      end
      before_action :configure_permitted_parameters, if: :devise_controller?

      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(
          :username,
          :email,
          :password,
          :password_confirmation,
          :current_password,
          :avatar,
          :description,
        )}
      end
end
