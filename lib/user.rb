require 'bcrypt'

class User

      include DataMapper::Resource

		  property :id, Serial
    	  property :name, String
    	  property :username, String, :unique => true, :message => "This username is taken"
     	  property :email, String, :unique => true, :message => "This email address is taken"
      	  property :password_digest, Text

	  def password=(password)
		 self.password_digest = BCrypt::Password.create(password)
	  end


end