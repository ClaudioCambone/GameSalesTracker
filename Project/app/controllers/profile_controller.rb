class ProfileController < ApplicationController
    layout 'navbar_layout'
    before_action :authenticate_user!, only: [:show, :edit, :update]
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to profile_profile_page_path, notice: 'Profile successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:description)
    end
  end
  