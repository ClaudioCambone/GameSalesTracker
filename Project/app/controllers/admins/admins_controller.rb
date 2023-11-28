class Admins::AdminsController < ApplicationController
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
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
            format.html { redirect_to admin_index_path notice: 'User was successfully deleted.' }
            format.json { head :no_content }
        end
    end
    
    
      private
    
      def authenticate_admin
        redirect_to root_path unless session[:admin_signed_in]
      end
      

end
