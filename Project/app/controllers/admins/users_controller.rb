class Admins::UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.admin?
          @users = User.all
          render 'admins/index'
        else
          flash[:alert] = "You do not have permission to access this page."
          redirect_to root_path
        end
    end
      
    #User-elimination
    def destroy
      puts "Params: #{params.inspect}"
      @user.destroy 
      redirect_to admins_index_path notice: 'User was successfully deleted.' 
    end
    
    #Perma-Ban
    def ban
      puts "Params: #{params.inspect}"
      @user = User.find(params[:id])
      @user.update(banned: true, ban_until: nil)
      redirect_to admins_index_path, notice: 'User banned successfully.'
    end
  
    def unban
      puts "Params: #{params.inspect}"
      @user = User.find(params[:id])
      @user.update(banned: false, ban_until: nil)
      redirect_to admins_index_path, notice: 'User unbanned successfully.'
    end
    
      private
    
      def authenticate_admin
        redirect_to root_path unless session[:admin_signed_in]
      end
      

end
