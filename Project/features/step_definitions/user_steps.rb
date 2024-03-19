########## USER CREATE ACCOUNT, LOGS IN, AND EDIT ACCOUNT INFORMATIONS ##########
Given("I visit the sign up page") do
    visit "/users/sign_up"
  end
  
  When("I fill in the registration form with valid information") do
    fill_in "Username", with: "Tartosso"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "typePasswordConfirmation", with: "password"
    click_button "Sign up"
  end
  
  And("I confirm my account via email") do
    user = User.find_by(email: "test@example.com")
    confirmation_token = user.confirmation_token
    visit "/users/confirmation?confirmation_token=" + confirmation_token
  end
  
  And("I sign in with my credentials") do
    click_button "Login"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Login"
  end
  
  Then("I should be successfully logged in") do
    expect(page).to have_content("Signed in successfully.")
  end
  
  And("I should be able to update my account information") do
    user = User.find_by(email: "test@example.com")
    id = user.id
    visit "/users/edit." + id.to_s
    fill_in "Username", with: "NewUsername"
    fill_in "user_password", with: "newpassword"
    fill_in "user_password_confirmation", with: "newpassword"
    click_button "Update"
    expect(page).to have_content("Your account has been updated successfully.")
  end
