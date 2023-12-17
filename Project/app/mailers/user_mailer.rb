class UserMailer < ApplicationMailer
    default :from => "gamesalestrackernoreply@gmail.com"
     
    
      def welcome_email(user)
        @user = user
        @url  = "http://localhost:3000/users/sign_up"
        mail(:to => user.email,  subject: 'Welcome to My App!')
      end

      def password_reset_email(user, token)
        @resource = user
        @token = token
        mail(to: user.email, subject: 'Password Reset')
      end

      def account_deleted_notification(user_email)
        mail(to: user_email, subject: 'Your account has been deleted, because you violated our policy')
      end

      def account_permabanned_notification(user_email)
        mail(to: user_email, subject: 'Your account has been permanently banned, because you violated our policy')
      end

      def account_tempban_notification(user_email, duration)
        @duration = duration
        mail(to: user_email, subject: 'Your account has been temporarly banned, because you violated our policy')
      end

      def account_unban_notification(user_email)
        mail(to: user_email, subject: 'Your account has been unbanned')
      end

      def account_makeadmin_notification(user_email)
        mail(to: user_email, subject: 'Your are officialy an admin')
      end

      def account_revokeadmin_notification(user_email)
        mail(to: user_email, subject: 'Your admin role has been revoked')
      end

      def support_email(support)
        @support = support
        mail(to: 'gamesalestrackernoreply@gmail.com', subject: 'Contact Form Submission')
      end
    end

  