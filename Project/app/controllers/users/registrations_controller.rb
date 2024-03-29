# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:edit, :update]

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation, :avatar, :description, :role)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar, :description)}
  end
  

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :avatar, :description)
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    logger.debug("Account update params: #{account_update_params.inspect}")
    
    @user = current_user


    ##i think this mehtod is useless, should be checked
    if needs_password?
      successfully_updated = @user.update_with_password(account_update_params)
    else
      # Remove password-related fields for non-password updates

      account_update_params.delete('current_password')

      # Update the user with the modified parameters
      successfully_updated = @user.update(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def edit
    super
  end

  private

  def needs_password?
    @user.email != params[:user][:email] || params[:user][:current_password].present?
  end
end
