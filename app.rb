require 'sinatra'
require 'sinatra/flash'
require_relative 'models'

enable :sessions

def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end


get '/' do
    erb :home
end

get '/signup' do

    erb :signup
end

post '/signup' do
    user = User.create(
    username: params[:username],
    password: params[:password],
    first_name: params[:firstname],
    Last_name: params[:lastname],
    Email: params[:email],
    birthday: params[:birthday]
    )
  
    session[:user_id] = user.id
    redirect "/profile"
end



get '/signin' do
  erb :signin

end

post '/signin' do
    user = User.find_by(username: params[:username])

    if user && user.password == params[:password]
      session[:user_id] = user.id
      redirect '/profile'
    else
      redirect '/signin'
    end

end

get '/profile' do
  if session[:user_id].nil?
    redirect "/"
  else
    erb :profile
end
end


get '/users' do
  if session[:user_id].nil?
    redirect "/"
  else

    @users= User.all
    erb :users
end
end


get '/logout' do
    session[:user_id] = nil
    redirect '/' 
end


post '/posts' do
        @posts = Post.create(
        title: params[:title],
        comment: params[:comment],
        user_id: current_user.id)
    redirect '/posts'
end

get '/posts' do
  if session[:user_id].nil?
    redirect "/"
  else 
    @posts= Post.all
    erb :post
  end
end

get '/settings' do
  if session[:user_id].nil?
    redirect "/"
  else
  erb :settings

end
end

post '/delete' do
    @user = User.find(session[:user_id])
    @post = Post.find_by(user_id: session[:user_id])
  #  
    @user.destroy
    session[:user_id] = nil
    redirect "/"
end


get '/mypost' do
  if session[:user_id].nil?
    redirect "/"
  else
  @user = current_user
  @posts = Post.where(user_id: session[:user_id])
  erb :mypost
end
end


get "/deletepost" do
  @post = Post.where(post_id: session[:user_id])

  erb :deletepost
end

delete '/deletepost'do
    @user = current_user
    @post = Post.find_by(user_id: session[:user_id])
    @post.destroy

    redirect '/mypost'
end