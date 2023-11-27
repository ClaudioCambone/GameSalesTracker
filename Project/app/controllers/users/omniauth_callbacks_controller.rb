  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    before_action :set_mapping


    def self.from_omniauth(auth)
      Rails.logger.debug "OmniAuth Data received: #{auth.inspect}"
  
      return unless auth
  
      user = User.where(email: auth.dig('info', 'email')).first
  
      if user
        Rails.logger.debug "User found by email: #{user.email}"
        user.update(provider: auth.provider, uid: auth.uid) if user.provider.nil? || user.uid.nil?
      else
        Rails.logger.debug "Creating a new user with OmniAuth data"
        user = User.create!(
          provider: auth.provider,
          uid: auth.uid,
          email: auth.dig('info', 'email') || auth.dig('info', 'user_info', 'email'), # Adjust the key based on provider
          password: Devise.friendly_token[0, 20]
        )
      end
    end


    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end

  
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user.username = request.env["omniauth.auth"].info.name if @user.username.blank?
      if @user.persisted?
        

        sign_in_and_redirect @user, event: :authentication, notice: "A confirmation E-mail has been sent to you"   
        set_flash_message(:notice, :success, kind: 'Facebook') if     is_navigational_format?
      else
        session['devise.facebook_data'] =  request.env['omniauth.auth'].except(:extra) 
        redirect_to new_user_registration_url
      end
    end
    
    
    def failure
      redirect_to root_path
    end
    
    # something wont'work
    def steam
      if request.env['omniauth.auth'].present?
        Rails.logger.debug "OmniAuth Data: #{request.env['omniauth.auth'].inspect}"
        @user = User.from_omniauth(request.env['omniauth.auth'])
        puts 'Start'
        puts @user
        puts 'End'
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Steam") if is_navigational_format?
        else
          session["devise.steam_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      else
        # Handle the case where omniauth.auth is nil
        redirect_to root_path, alert: "Authentication data not received from Steam."
      end
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
    flash[:message] = "Authentication via Google successful"
    

  end

  # something wont'work
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private

  def set_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
end



