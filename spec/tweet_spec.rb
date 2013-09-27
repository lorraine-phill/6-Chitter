    require 'spec_helper'

    describe Tweet do

      context "Demonstration of how datamapper works" do

        it 'should be created and then retrieved from the db' do
          expect(Tweet.count).to eq(0)
          Tweet.create(:tweet_post => "My first chit!")
          expect(Tweet.count).to eq(1)
          tweet = Tweet.first
          expect(tweet.tweet_post).to eq("My first chit!")
          tweet.destroy
          expect(Tweet.count).to eq(0)

        end
      end
    end