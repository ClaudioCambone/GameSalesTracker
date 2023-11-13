class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers:  %i[facebook google_oauth2]
  
  # Omniauth modules

  def self.from_omniauth(auth)
    # This line checks if the user email received by the Omniauth is already included in our databases.
      user = User.where(email: auth.info.email).first
    # This line sets the user unless there is a user found in the line above, therefore we use ||= notation to evaluate if the user is nill, then set it to the User.create
      user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
    end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && self.provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
  def has_no_password?
    self.encrypted_password.blank?
  end
end