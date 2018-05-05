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
    erb :'users/login.erb'
  end

end