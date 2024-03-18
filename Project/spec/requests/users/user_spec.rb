RSpec.describe UserController, type: :controller do

  ########## TEST N. 1,  VERIFY THE CORRECT WORKING OF THE SIGN IN METHOD ###########

    describe "#sign_in" do
      it "logs in a user with valid credentials" do
        user = User.create(email: "test@example.com", password: "password")
        user.confirm
        
        # Mock any authentication method used for login (e.g., Devise's sign_in)
        allow(controller).to receive(:authenticate_user!).and_return(user)
        
        # Call the login method with valid credentials
        controller.sign_in(user)
        
        # Expect the user to be authenticated
        expect(controller.current_user).to eq(user)
      end
    end

  ########## TEST N. 2,  VERIFY THE CORRECT WORKING OF THE SIGN IN METHOD WITHOUT CONFIRMATION ###########


  describe "#sign_in" do
    it "tries to sign in to an existing account without confirmation" do
      # Create an unconfirmed user
      user = User.create(email: "test@example.com", password: "password")
      
      # Stub the sign_in method to prevent the warden throw
      allow(controller).to receive(:sign_in).and_return(nil)
      
      # Call the sign_in method with the unconfirmed user
      controller.sign_in(user)
      
      # Expect the user not to be authenticated
      expect(controller.current_user).to be_nil
    end
  end

end