class SupportController < ApplicationController
    before_action :authenticate_user!, only: [:new]
  
    def new
      @support = Support.new(username: current_user.username, email: current_user.email)
    end
  
    def create
      @support = Support.new(support_params)
        UserMailer.support_email(@support).deliver_now
        redirect_to root_path, notice: 'Your message has been sent. Thank you!'
    end
  
    private
  
    def support_params
      params.require(:support).permit(:username, :email, :message)
    end
  end
  