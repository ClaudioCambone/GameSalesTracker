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
      @user = User.find(params[:id])
      if @user.destroy
      # Send an email to the user using your mailer
      UserMailer.account_deleted_notification(@user.email).deliver_now

      redirect_to admins_index_path, notice: 'User was successfully deleted.'
    else
      redirect_to admins_index_path, alert: 'Failed to delete the user.'
    end
    end
    
    #Perma-Ban
    def ban
      puts "Params: #{params.inspect}"
      @user = User.find(params[:id])
      @user.update(banned: true, ban_until: nil)
      UserMailer.account_permabanned_notification(@user.email).deliver_now
      redirect_to admins_index_path, notice: 'User banned successfully.'
    end

    #admin can choose the duration of a ban
    def temporary_ban
      @user = User.find(params[:id])
      duration = params[:duration].to_i.days
      @user.update(banned: true, ban_until: Time.current + duration)
      UserMailer.account_tempban_notification(@user.email, Time.current + duration).deliver_now
      redirect_to admins_index_path, notice: "User temporarily banned successfully"
    end
    
    #admin can manually unban users
    def unban
      puts "Params: #{params.inspect}"
      @user = User.find(params[:id])
      @user.update(banned: false, ban_until: nil)
      UserMailer.account_unban_notification(@user.email).deliver_now
      redirect_to admins_index_path, notice: 'User unbanned successfully.'
    end

    #amdins can give to other users admins privlieges 
    def make_admin
      @user = User.find(params[:id])
      @user.update(role: 'admin')
      UserMailer.account_makeadmin_notification(@user.email).deliver_now
      redirect_to admins_index_path, notice: 'User is now an admin.'
    end
    
    #admins can revoke admins privileges to others
    def revoke_admin
      @user = User.find(params[:id])
      @user.update(role: 'user')
      UserMailer.account_revokeadmin_notification(@user.email).deliver_now
      redirect_to admins_index_path, notice: 'Admin is now a user.'
    end
    
      private
    #only admin can use these methods
      def authenticate_admin
        redirect_to root_path unless session[:admin_signed_in]
      end
      

end
