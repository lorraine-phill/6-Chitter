    require 'spec_helper'

    feature "User signs up" do

      scenario "when being logged out" do    
        lambda { sign_up }.should change(User, :count).by(1)    
        expect(page).to have_content("Welcome, lorraine@test.com")
        expect(User.first.name).to eq("lorraine") 
        expect(User.first.username).to eq("lpbest")        
        expect(User.first.email).to eq("lorraine@test.com")
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