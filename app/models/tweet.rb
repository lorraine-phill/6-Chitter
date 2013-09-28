    class Tweet


      include DataMapper::Resource

      property :id,     Serial # Serial means that it will be auto-incremented for every record
      property :tweet_post,  String

    end

