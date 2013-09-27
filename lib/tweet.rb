    class Tweet


      include DataMapper::Resource

      # This block describes what resources our model will have

      property :id,     Serial # Serial means that it will be auto-incremented for every record
      property :tweet_post,  String

    end

