class UserController < ApplicationController
  layout 'layouts/navbar_layout'
  include SharedHelper
  # POST /users or /users.json
  before_action :authenticate_user!
  before_action :set_api_key
  
def create
  @user = User.new(user_params)

  respond_to do |format|
    if @user.save
      ApplicationMailer.with(user: @user).welcome_email.deliver_now

      format.html { redirect_to @user, notice: 'User was successfully created.' }
      format.json { render json: @user, status: :created, location: @user }
    else
      format.html { render action: 'new' }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

def set_api_key
  @api_key = 'b14274e8092bc14e227b32e4b66c2903bf4419c9'
end

def panel
  if current_user.admin?
    @users = User.all
    render 'admins/panel'
  else
    flash[:alert] = "You do not have permission to access this page."
    redirect_to root_path
  end
end

  def show
    @user = current_user
  end

  def index
    @user = current_user
    @collections = @user.collections
  end


  def user_comments
    @user_comments = current_user.comments
  end

  def destroy
    @user = current_user
    Comment.where(user_id: @user.id).destroy_all # Delete associated comments
    Collections.where(user_id: @user.id).destroy_all
    if @user.destroy
    redirect_to root_path, notice: 'Account deleted successfully.'
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
end