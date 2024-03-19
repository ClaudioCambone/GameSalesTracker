require 'rails_helper'

RSpec.describe "Filtering Deals Feature", type: :feature do
  describe "Filtering deals feature", type: :feature do

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
      
      #puts page.body

    end

    it "verifies absence of specific content" do
      expect(page).not_to have_content('{"status_code": 0, "reason_phrase": "string"}')
    end

  end  
end

