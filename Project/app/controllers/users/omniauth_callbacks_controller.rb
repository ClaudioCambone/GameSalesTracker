  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user.username = request.env["omniauth.auth"].info.name if @user.username.blank?
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication   
        set_flash_message(:notice, :success, kind: 'Facebook') if     is_navigational_format?
        UserMailer.welcome_email(@user).deliver_now
      else
        session['devise.facebook_data'] =  request.env['omniauth.auth'].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
    
    
    def failure
      redirect_to root_path
    end
    
    
    def google_oauth2
      auth = request.env['omniauth.auth']

    # Find or create the user by email
    @user = User.find_or_initialize_by(email: auth.info.email)
    @user.username = request.env["omniauth.auth"].info.name if @user.username.blank?
    # Set username only for users registered with email (not via Google)
    unless @user.persisted?
      @user.username = auth.info.name.parameterize # You can adjust the logic to generate a username
      @user.password = Devise.friendly_token[0, 20]
      @user.save
    end

    sign_in_and_redirect @user, event: :authentication
  end
    
end



