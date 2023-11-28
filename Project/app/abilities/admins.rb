Canard::Abilities.for(:user) do
  
    def initialize(user)
      user ||= User.new
  
      if user.admin?
        can :manage, :admin # Assuming :admin is the resource for admin actions
      else
        # Define abilities for non-admin users
      end
    end
  end