require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"

set :database, "sqlite3:erinsblogdb.sqlite3"

enable :sessions

get '/' do
	@user = current_user
	if @user
		@posts = Post.all 
		erb :index
	else
	redirect '/sign-in'
	end	
end

get '/sign-in' do 
	erb :'sign-in'
end

get '/index' do
	@user = current_user
	@posts = Post.all
	erb :index
end

get '/sign-up' do
	erb :'sign-up'
end

post '/sign-in' do
	@user = User.where(email: params[:email]).last
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You have successfully signed in."
		redirect '/index'
	else
		flash[:alert] = "Your email or password is incorrect."
		redirect '/sign-in'
	end
end

post '/sign-up' do
	@user = User.create(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password])
	redirect '/sign-in'
end

post '/new-post' do
	@posts = Post.all
	erb :'new-post'
	redirect :index
end

get '/new-post' do
	@posts = Post.new(params[:post])
	erb :'new-post'
end

get '/logout' do
	session.clear
	redirect '/sign-in'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

