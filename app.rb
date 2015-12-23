require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"

set :database, "sqlite3:erinsblogdb.sqlite3"

get '/' do
	erb :'sign-in'	
end