class UserController < ApplicationController
  # POST /users or /users.json
end
  def create
      @user = User.new(user_params)
      @user.save
      unless  @user.save
        @error_message = errors.full_messages.compact
      end
    end

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_now

        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  
end