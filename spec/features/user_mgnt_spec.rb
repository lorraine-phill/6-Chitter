    require 'spec_helper'

    feature "User signs up" do

      scenario "when being logged out" do    
        lambda { sign_up }.should change(User, :count).by(1)    
        expect(page).to have_content("Welcome, lorraine@test.com")
        expect(User.first.name).to eq("lorraine") 
        expect(User.first.username).to eq("lpbest")        
        expect(User.first.email).to eq("lorraine@test.com")
      end

      scenario "with a password that doesn't match" do
        lambda { sign_up('lorraine', 'lpbest', 'lorraine@test.com', 'makers', 'make') }.should change(User, :count).by(0)    
        expect(current_path).to eq('/users')   
        expect(page).to have_content("Sorry, there were the following problems with the form.")
      end

      scenario "with an email that is already registered" do    
        lambda { sign_up }.should change(User, :count).by(1)
        lambda { sign_up }.should change(User, :count).by(0)
        expect(page).to have_content("This email address is taken")
      end

      scenario "with a username that is already registered" do    
        lambda { sign_up }.should change(User, :count).by(1)
        lambda { sign_up }.should change(User, :count).by(0)
        expect(page).to have_content("This username is taken")
      end

      def sign_up(name = "lorraine",
                  username = "lpbest",
                  email = "lorraine@test.com", 
                  password = "makers", 
                  password_confirmation = 'makers')
        visit '/users/new'
        fill_in :name, :with => name
        fill_in :username, :with => username
        fill_in :email, :with => email
        fill_in :password, :with => password
        fill_in :password_confirmation, :with => password_confirmation
        click_button "Sign up now, homie!"
      end

end