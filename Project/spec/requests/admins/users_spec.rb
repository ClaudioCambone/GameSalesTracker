require 'spec_helper'

RSpec.describe Admins::UsersController, type: :controller do
  before(:each) do
    #create an example user for every test

    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: 'user') 
  end

  describe "POST #ban" do
    context "when banning a user" do
      it "updates the user's banned status to true and ban_until to nil" do
        user_to_ban = @user
        user_to_ban.confirm # Confirm the user email
        sign_in user_to_ban # Sign in the user


        #testing ban method
        post :ban, params: { id: user_to_ban.id } 
      
        user_to_ban.reload
        expect(user_to_ban.banned?).to be_truthy
        expect(user_to_ban.ban_until).to be_nil
      end
    end
  end
  describe "POST #temporary_ban" do
    context "when temporarily banning a user" do
      it "updates the user's banned status to true and sets ban_until to the specified duration" do
        user_tempban = @user
        user_tempban.confirm # Confirm the user email
        sign_in user_tempban # Sign in the user
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
  describe "POST #make_admin" do
    context "when making a user an admin" do
      it "updates the user's role to 'admin'" do
        user_to_make_admin = @user
        user_to_make_admin.confirm # Confirm the user email
        sign_in user_to_make_admin # Sign in the user

        post :make_admin, params: { id: user_to_make_admin.id }

        user_to_make_admin.reload
        expect(user_to_make_admin.role).to eq('admin')
      end
    end
  end
end

# User Load (0.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
# ↳ app/controllers/admins/users_controller.rb:32:in `ban'
# TRANSACTION (0.1ms)  begin transaction
# ↳ app/controllers/admins/users_controller.rb:33:in `ban'
# ActiveStorage::Attachment Load (0.1ms)  SELECT "active_storage_attachments".* FROM "active_storage_attachments" WHERE "active_storage_attachments"."record_id" = ? AND "active_storage_attachments"."record_type" = ? AND "active_storage_attachments"."name" = ? LIMIT ?  [["record_id", 2], ["record_type", "User"], ["name", "avatar"], ["LIMIT", 1]]
# ↳ app/controllers/admins/users_controller.rb:33:in `ban'
# User Update (0.4ms)  UPDATE "users" SET "updated_at" = ?, "banned" = ? WHERE "users"."id" = ?  [["updated_at", "2024-03-18 13:57:49.733572"], ["banned", 1], ["id", 2]]
# ↳ app/controllers/admins/users_controller.rb:33:in `ban'
# TRANSACTION (1.5ms)  commit transaction



# describe "POST #ban" do
#   context "when banning a user" do
#     it "updates the user's banned status to true and ban_until to nil" do
#       @user_to_ban.banned= true;
#       @user_to_ban.save
#       @user_to_ban.reload # Reload the user from the database to get the updated attributes
#       expect(@user_to_ban.banned).to be_truthy # Check if the user is banned
#       expect(@user_to_ban.ban_until).to be_nil # Check if the ban_until is nil
#     end


###WORKING TEST FOR ACCOUNT CONFIRMATION
# describe "POST #ban" do
#   context "when banning a user" do
#     it "updates the user's banned status to true and ban_until to nil" do
#       user = User.first
#       @user_to_ban.confirm
#       @user_to_ban.banned = true
      
#       @user_to_ban.reload # Reload the user from the database to get the updated attributes
#       expect(@user_to_ban.confirmed?).to be_truthy # Check if the user is banned
#       expect(@user_to_ban.ban_until).to be_nil # Check if the ban_until is nil
#     end