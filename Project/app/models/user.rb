class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable , :omniauthable, omniauth_providers:  %i[facebook google_oauth2 steam github]
  
  validates :password, presence: true, if: -> { password.present? }



  before_create :set_default_role


  # This ensures that new users have a default role of "user" unless explixity said that they are "admins"

  def set_default_role
    self.role ||= 'user'
  end
 

  def admin?
    role == 'admin'
  end

  
  ##...Avatar Attachment...##
  has_one_attached :avatar

  ## Validations
     validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes },
                file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
  


  def registered_with_email?
    provider.blank? # Assuming 'provider' is the attribute indicating the authentication provider
  end

  # Omniauth modules

  def self.from_omniauth(auth)
    # This line checks if the user email received by the Omniauth is already included in our databases.
      user = User.where(email: auth.info.email).first
      puts "------------------------------------"
      puts auth.info.mail
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
    false
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

