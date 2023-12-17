# app/models/support.rb
class Support
    include ActiveModel::Model
  
    attr_accessor :username, :email, :message
  
    validates :username, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :message, presence: true
  end
  