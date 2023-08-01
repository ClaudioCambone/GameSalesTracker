# frozen_string_literal: true

class Users::Sessions::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
       sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => user.provider.titleize
    else
        session["devise.user_attributes"] = request.env["omniauth.auth"] #create a cookie with omniauth hash to give it another try, for example in a already register email
       redirect_to new_user_registration_url
    end 
  end

  //alias method is for have the same method for various strategies(google, twitter, etc)
  alias_method :facebook, :all

end
