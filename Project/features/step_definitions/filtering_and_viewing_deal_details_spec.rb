Given("I am on the homepage") do
  visit root_path
end

When("I apply the selected filter options and click on the first deal title") do
  select "20", from: "limit-select"
  select 'Price (min)', from: "sort-select"
  select "Steam", from: "shop-filter-select"
  click_button "Apply"
  
  # Aggiungo un'attesa esplicita per garantire che la pagina sia caricata prima di continuare
  expect(page).to have_selector('.card-title')
  
  # Ottengo l'URL del primo titolo del deal
  @deal_url_before_click = first('.card-title a')['href']
  # Faccio clic sul primo titolo del deal
  first('.card-title a').click
end

Then("I should be redirected to the login page") do
  expect(page).to have_content('You need to sign in or sign up before continuing.')
end

When("I log in with valid credentials") do
  user = User.create(username: "Tartosso", email: "valid@example.com", password: "password")
  user.confirm

  fill_in "Email", with: "valid@example.com"
  fill_in "Password", with: "password"
  click_button "Login"
  
  # Aggiungo un'attesa esplicita per garantire che la pagina sia caricata dopo l'accesso
  expect(page).to have_content('Signed in successfully.')
end

Then("I should be redirected to the deal details page") do
  # Verifico che l'URL della pagina sia quello previsto
  expect(page).to have_current_path(@deal_url_before_click)
  expect(page).to have_content('Game Details')
end
