require 'rails_helper'

RSpec.describe "Filtering and Viewing Deal Details Feature", type: :feature do
  describe "Filtering deals and viewing details feature", type: :feature do
    
    before :each do
      visit 'http://localhost:3000/'
    end

    it "applies the selected filter options and displays the filtered deals" do
        #puts page.body
        #save_and_open_page
    
        select "20", from: "limit-select"
        select 'Price (min)', from: "sort-select"
        select "Steam", from: "shop-filter-select"
    
        click_button "Apply"
    
        # Verifica che ci siano degli elementi dei deal presenti sulla pagina
        expect(page).to have_css('.card-tilt')
        
        # Ottieni l'URL del primo dettaglio del deal prima del click
        deal_url_before_click = first('.card-title a')['href']

        # Clicca sul primo dettaglio del deal
        first('.card-title a').click
        
        # Verifica che siamo stati reindirizzati alla pagina di login prima di poter continuare
        expect(page).to have_content('You need to sign in or sign up before continuing.')
        #puts page.body
        
        #facciamo il login per continuare
        login_with_valid_credentials

        # Verifica che siamo stati reindirizzati alla pagina dei dettagli del deal dopo aver effettuato il login
        expect(page).to have_current_path(deal_url_before_click)
        
        # Assicurati che i dettagli del deal siano presenti sulla pagina
        expect(page).to have_content(' Details')
        save_and_open_page

    end

    def login_with_valid_credentials
        user = User.create(username: "Tartosso", email: "valid@example.com", password: "password")
        user.confirm
  
        fill_in "Email", with: "valid@example.com"
        fill_in "Password", with: "password"
        click_button "Login"
      end

  end  
end
