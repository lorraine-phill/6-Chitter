    require 'spec_helper'

    feature "User browses the list of tweets" do
      before(:each) {
        Tweet.create(:tweet_post => "My first Chit!")
      }

      scenario "when opening the home page" do
        visit '/'
        expect(page).to have_content("My first Chit!")

      end

    end