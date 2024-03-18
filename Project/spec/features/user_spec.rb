require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  ########## TEST N. 1 TRYING TO MODIFY A USER NAME AND PASSWORD ##########
  describe "Modify User", type: :feature do
    it "modifies user name and password" do
      user = User.create(username: "Tartosso", email: "modify@example.com", password: "oldpassword")
      user.confirm
      id = user.id
      visit "http://localhost:3000/users/sign_in"

      fill_in "Email", with: "modify@example.com"
      fill_in "Password", with: "oldpassword"
      click_button "Login"

      expect(page).to have_content("Signed in successfully.")

      visit "http://localhost:3000/users/edit." + id.to_s

      fill_in "Username", with: "NewUsername"
      fill_in "user_password", with: "newpassword"
      fill_in "user_password_confirmation", with: "newpassword"
      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully.")
    end
  end

  ########## TEST N.2 LOG IN WITH INVALID CREDENTIALS ##########
  describe "Invalid Login", type: :feature do
    it "logs in with invalid credentials" do
      user = User.create(username: "Tartosso", email: "invalid@example.com", password: "differenpassword")
      user.confirm
      id = user.id
      visit "http://localhost:3000/users/sign_in"

      fill_in "Email", with: "invalid@example.com"
      fill_in "Password", with: "password"
      click_button "Login"
      expect(page).to have_content("Invalid Email or password.")

      fill_in "Email", with: "wrong@example.com"
      fill_in "Password", with: "differenpassword"
      click_button "Login"
      expect(page).to have_content("Invalid Email or password.")

      fill_in "Email", with: "invalid@example.com"
      fill_in "Password", with: "differenpassword"
      click_button "Login"
      expect(page).to have_content("Signed in successfully.")
    end
  end

  ######## TEST N. 3 TRYING TO CREATE, CONFIRM AND SIGN IN A USER ##########
  scenario "User registers an account, confirms, and signs in" do
    visit "http://localhost:3000/users/sign_up"

    fill_in "Username", with: "Tartosso"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "typePasswordConfirmation", with: "password"

    click_button "Sign up"

    user = User.find_by(email: "test@example.com")
    confirmation_token = user.confirmation_token
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account")

    visit "http://localhost:3000/users/confirmation?confirmation_token=" + confirmation_token

    visit "http://localhost:3000/users/sign_in"

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Signed in successfully.")

    id = user.id
    visit "http://localhost:3000/users/edit." + id.to_s

    fill_in "Username", with: "NewUsername"
    fill_in "user_password", with: "newpassword"
    fill_in "user_password_confirmation", with: "newpassword"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end
end
