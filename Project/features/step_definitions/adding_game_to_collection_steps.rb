Given("I am a logged-in user") do
    # Create a user and sign in
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password', role: 'user')
    @user.confirm
    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Login"
    expect(page).to have_content("Signed in successfully.")
  end
  
  Given("I have collections named {string} and {string}") do |collection1_name, collection2_name|
    # Create collections for the user with associated IDs
    @collection1 = Collection.create(name: collection1_name, user_id: @user.id)
    @collection2 = Collection.create(name: collection2_name, user_id: @user.id)
  end
  
  When("I visit the game details page for a specific game") do
    # For testing purposes, let's assume we have a valid game_id
    game_id = '018d937f-2b23-73a3-9b40-d93860065d00'
    visit details_game_path(game_id)
  end
  
  When("I select {string} from the collection dropdown") do |collection_name|
    select collection_name, from: "collection-dropdown"
  end
  
  When("I click the {string} button") do |button_text|
    click_button button_text
  end
  
  Then("I should see a success message indicating the game was added to the collection") do
    expect(page).to have_content("Game added to collection successfully.")
  end
  