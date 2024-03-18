require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  scenario "User can register an account and sign in" do
    # Registering an account
    visit "http://localhost:3000/users/sign_up"


    fill_in "Username", with: "Tartosso"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Sign up"

    # Check for the confirmation message
    expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account")

    # Retrieve the confirmation token from the database
    user = User.find_by(email: "test@example.com")
    confirmation_token = user.confirmation_token

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
