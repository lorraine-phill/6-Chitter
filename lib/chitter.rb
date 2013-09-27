require 'sinatra/base'
require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/tweet' # this needs to be done after datamapper is initialised
DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base
  get '/' do
    'Hello from Chitter app!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
