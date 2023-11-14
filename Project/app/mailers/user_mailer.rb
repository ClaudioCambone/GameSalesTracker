class UserMailer < ApplicationMailer
    default :from => "cambone750@gmail.com"
     
      def welcome_email(user)
        @user = user
        @url  = "http://localhost:3000/users/sign_up"
        mail(:to => user.email,  subject: 'Welcome to My App!')
      end
    end
  