class ProfileController < ApplicationController
  layout 'navbar_layout'
  before_action :authenticate_user!, only: [:show, :edit, :update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user

    if current_user.provider.present?
      # For Omniauth users, ask for a password first
      flash.now[:notice] = 'To edit your profile, please create an account directly on the site.'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Username updated successfully.'
    else
      flash[:alert] = 'Failed to update username. Check the logs for more information.'
      Rails.logger.error("Failed to update username: #{user.errors.full_messages.join(', ')}")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :current_password, :description)
  end
  
end
