require 'spec_helper'

RSpec.describe Admins::UsersController, type: :controller do
  before(:each) do
    #create an example user for every test
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: 'user')
    @user.confirm # Confirm the user email
    sign_in @user # Sign in the user 
  end
  # ########## TEST N. 1, VERIFY THE CORRECT WORKING OF THE BAN METHOD ###########
  describe "POST #ban" do
    context "when banning a user" do
      it "updates the user's banned status to true and ban_until to nil" do
        user_to_ban = @user

        #testing ban method
        post :ban, params: { id: user_to_ban.id } 
      
        user_to_ban.reload
        expect(user_to_ban.banned?).to be_truthy
        expect(user_to_ban.ban_until).to be_nil
      end
    end
  end

  ########## TEST N. 2,  VERIFY THE CORRECT WORKING OF THE TEMPORARY BAN METHOD###########

  describe "POST #temporary_ban" do
    context "when temporarily banning a user" do
      it "updates the user's banned status to true and sets ban_until to the specified duration" do
        user_tempban = @user
        duration_in_days = 7
        #  Inside Timecop.freeze, Time.current is always the same
        #In this way, we can verify that the ban lasts for a week
        Timecop.freeze do
          post :temporary_ban, params: { id: user_tempban.id, duration: duration_in_days }
          user_tempban.reload
        expect(user_tempban.banned?).to be_truthy
        expect(user_tempban.ban_until).to eq(Time.current + duration_in_days.days)
        end
      end
    end
  end

  ########## TEST N. 3, VERIFY THE CORRECT WORKING OF THE MAKE ADMIN METHOD ###########

  describe "POST #make_admin" do
    context "when making a user an admin" do
      it "updates the user's role to 'admin'" do
        user_to_make_admin = @user

        post :make_admin, params: { id: user_to_make_admin.id }

        user_to_make_admin.reload
        expect(user_to_make_admin.role).to eq('admin')
      end
    end
  end
end
