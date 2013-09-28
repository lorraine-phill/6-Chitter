require 'sinatra/base'
require 'sinatra'
require 'data_mapper'
require 'rack-flash'
use Rack::Flash
require_relative 'models/user'
require_relative 'models/tweet'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
	
	get '/' do
      @tweet = Tweet.all
      erb :index
	end

	post '/tweets' do
	  tweet_post = params["tweet_post"]
      Tweet.create(:tweet_post => tweet_post)
      redirect to('/')
	end

	get '/users/new' do
	   @user = User.new
	   erb :"users/new"
	end

	post '/users' do
		@user = User.new(:name => params[:name],
		      	:username => params[:username],
		      	:email => params[:email],
		        :password => params[:password],
				:password_confirmation => params[:password_confirmation])  
		if @user.save
			session[:user_id] = @user.id
    		redirect to('/')
		else
    		flash.now[:errors] = @user.errors.full_messages
     		erb :"users/new"
 		end
	end    

	get '/sessions/new' do
      erb :"sessions/new"
    end

    post '/sessions' do
	    email, password = params[:email], params[:password]
	    user = User.authenticate(email, password)
	    if user
	      session[:user_id] = user.id
	      redirect to('/')
	    else
	      flash[:errors] = ["The email or password are incorrect"]
	      erb :"sessions/new"
	    end
    end