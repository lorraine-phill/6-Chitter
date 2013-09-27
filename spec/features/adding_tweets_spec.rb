    require 'spec_helper'

    feature "User adds a new tweet" do

      scenario "when browsing the homepage" do
        expect(Tweet.count).to eq(0)
        visit '/'
        add_tweet("This is my first tweet on this application!")
        expect(Tweet.count).to eq(1)
        tweet = Tweet.first
        expect(tweet.tweet_post).to eq("This is my first tweet on this application!")
      end

      def add_tweet(tweet_post)
          within('#new-tweet') do
          fill_in 'tweet_post', :with => tweet_post
          click_button 'Add this tweet'
        end      
      end
      
    end