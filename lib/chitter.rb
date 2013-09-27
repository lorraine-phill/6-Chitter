require 'sinatra/base'
require 'sinatra'
require 'data_mapper'
require 'user'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/tweet' # this needs to be done after datamapper is initialised
require './lib/user'
DataMapper.finalize
DataMapper.auto_upgrade!


class Chitter < Sinatra::Base

	enable :sessions
	set :session_secret, 'super secret'

	set :views, File.join(File.dirname(__FILE__), '..', 'views')
	
	helpers do
      	def current_user    
			@current_user ||=User.get(session[:user_id]) if session[:user_id]
		end
	end

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
		erb :"users/new"
	end

	post '/users' do
			user = User.create(:name => params[:name],
	      	:username => params[:username],
	      	:email => params[:email],
	        :password => params[:password],
			:password_confirmation => params[:password_confirmation])  
			session[:user_id] = user.id
			redirect to('/')
	end

	# start the server if ruby file executed directly
	run! if app_file == $0
	
end
