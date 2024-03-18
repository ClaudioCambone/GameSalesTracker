require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  ######### TEST N. 1 TRYING TO CREATE, CONFIRM AND SIGN IN A USER ##########
  scenario "User register an account and sign in" do
    visit "http://localhost:3000/users/sign_up"


    fill_in "Username", with: "Tartosso"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "typePasswordConfirmation", with: "password"

    click_button "Sign up"

    # Check for the confirmation message

    # Retrieve the confirmation token from the database
    user = User.find_by(email: "test@example.com")
    confirmation_token = user.confirmation_token
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account")


    # Simulate visiting the confirmation link
    visit "http://localhost:3000/users/confirmation?confirmation_token=" + confirmation_token

    # Check for the confirmation message

    # Sign in with the registered account
    visit "http://localhost:3000/users/sign_in"

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    # Check for successful sign-in
    expect(page).to have_content("Signed in successfully.")
  end
  ########## TEST N. 2 TRYING TO MODIFY A USER NAME PASSWORD AND AVATAR ##########
  scenario "User can modify credentials and sign in with updated credentials" do
    # Create an existing user
    user = User.create(username: "Tartosso", email: "existing@example.com", password: "oldpassword")
    user.confirm
    id = user.id
    visit "http://localhost:3000/users/sign_in"

      fill_in "Email", with: "existing@example.com"
      fill_in "Password", with: "oldpassword"
      click_button "Login"

    # Check for successful sign-in
    expect(page).to have_content("Signed in successfully.")

    # Navigate to the edit profile page
    visit "http://localhost:3000/users/edit." + id.to_s

    # Modify username and password
    fill_in "Username", with: "NewUsername"
    fill_in "user_password", with: "newpassword"
    fill_in "user_password_confirmation", with: "newpassword"
    click_button "Update"

    # Check for successful update message
    expect(page).to have_content("Your account has been updated successfully.")
  end
  ########## TEST N.3 INVALID CREDENTIALS ##########
end


  # scenario "User can log in to their account" do
  #   user = User.create(email: "test@example.com", password: "password")

  #   visit new_user_session_path

  #   fill_in "Email", with: "test@example.com"
  #   fill_in "Password", with: "password"
  #   click_button "Log in"

  #   expect(page).to have_content("Signed in successfully.")
  # end

  # Add more scenarios as needed...
