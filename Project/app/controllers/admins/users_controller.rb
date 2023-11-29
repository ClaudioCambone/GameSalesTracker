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
      
      def destroy
        puts "Params: #{params.inspect}" # Add this line
        @user = User.find(params[:id])
        @user.destroy 
           redirect_to admins_index_path notice: 'User was successfully deleted.' 
    end
    
    
      private
    
      def authenticate_admin
        redirect_to root_path unless session[:admin_signed_in]
      end
      

end
