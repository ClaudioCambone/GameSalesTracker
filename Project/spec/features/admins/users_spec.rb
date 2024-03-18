RSpec.feature "Administration", type: :feature do
 ######## TEST N. 1 TRYING TO LOG IN, ENTER ADMIN PANEL AND PERMABAN A USER ##########
    # Create two existing user, one with admin role and one user role
    scenario "User register an account and sign in" do
        userAdmin = User.create(username: "Admin", email: "admin@example.com", password: "admin", role: "admin")
        userBase = User.create(username: "user", email: "user@example.com", password: "user", role: "user")
        userAdmin.confirm
        userBase.confirm
        id = userAdmin.id
        
        visit "http://localhost:3000/users/sign_in"

        fill_in "Email", with: "admin@example.com"
        fill_in "Password", with: "admin"
        click_button "Login"
        expect(page).to have_content("Signed in successfully.")

        visit "http://localhost:3000/admins/index"
        expect(page).to have_content("Admin Panel")

        user_row = find('tr', text: 'user@example.com')
        expect(user_row).to have_content("user@example.com")

        # Click the "PermaBan" button for the user
        within user_row do
        click_button "PermaBan"
        end
        
        # For debug only 
        # save_and_open_page

        expect(page).to have_content("User banned successfully.")

    end
 ######## TEST N. 2 TRYING TO LOG IN, ENTER ADMIN PANEL AND PERMABAN A USER ##########
    # Create two existing user, one with admin role and one user role
    scenario "User register an account and sign in" do
        userAdmin = User.create(username: "Admin", email: "admin@example.com", password: "admin", role: "admin")
        userBase = User.create(username: "user", email: "user@example.com", password: "user", role: "user")
        userAdmin.confirm
        userBase.confirm
        id = userAdmin.id
        
        visit "http://localhost:3000/users/sign_in"

        fill_in "Email", with: "admin@example.com"
        fill_in "Password", with: "admin"
        click_button "Login"
        expect(page).to have_content("Signed in successfully.")

        visit "http://localhost:3000/admins/index"
        expect(page).to have_content("Admin Panel")

        user_row = find('tr', text: 'user@example.com')
        expect(user_row).to have_content("user@example.com")

            # Click the "Make Admin" button for the user
        within user_row do
        click_button "Make Admin"
        end
        

        expect(page).to have_content("User is now an admin.")

    end
end