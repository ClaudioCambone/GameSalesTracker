# frozen_string_literal: true

class Users::Sessions::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  #def destroy
    # Custom code here, if needed.

    # Call the Devise sign_out method to handle the logout logic.
  #  super
  #end
  def create
    auth = request.env['omniauth.auth']
  end
  

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
