class UsersController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"users/new_user"
    end
  end

  post '/users/signup' do
    @user = User.new(params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/users/signup"
    end
  end

  get '/users/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'users/login'
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/users/login'
    end
  end

  get '/users/logout' do
    session.clear
    redirect '/users/login'
  end

end