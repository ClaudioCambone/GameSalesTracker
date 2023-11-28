class UserController < ApplicationController
  layout 'layouts/navbar_layout'
  # POST /users or /users.json
  
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

  def show
    @user = current_user
  end

  def destroy
    @user = current_user
    authorize! :destroy, @user

  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end
  
end