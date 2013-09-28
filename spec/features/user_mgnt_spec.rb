require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

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
end

feature "User signs in" do

      before(:each) do
        User.create(:email => "test@test.com", 
                    :password => 'test', 
                    :password_confirmation => 'test')
      end

      scenario "with correct credentials" do
        visit '/'
        expect(page).not_to have_content("Welcome, test@test.com")
        sign_in('test@test.com', 'test')
        expect(page).to have_content("Welcome, test@test.com")
      end

      scenario "with incorrect credentials" do
        visit '/'
        expect(page).not_to have_content("Welcome, test@test.com")
        sign_in('test@test.com', 'wrong')
        expect(page).not_to have_content("Welcome, test@test.com")
      end
end

feature 'User signs out' do

      before(:each) do
       User.create(:email => "test@test.com", 
                    :password => 'test', 
                    :password_confirmation => 'test')
      end

      scenario 'while being signed in' do
        sign_in('test@test.com', 'test')
        click_button "Sign out"
        expect(page).to have_content("Good bye. Hope to see you soon!")
        expect(page).not_to have_content("Welcome, test@test.com")
      end
end