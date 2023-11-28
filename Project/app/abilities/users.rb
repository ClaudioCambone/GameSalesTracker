Canard::Abilities.for(:user) do
  def initialize(user)
    user ||= User.new

    can :read, :all
  end
end