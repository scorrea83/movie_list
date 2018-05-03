class UsersController < ApplicationController

  get '/users/signup' do
    erb :"users/new_user"
  end

  post '/users/signup' do
    @user = User.new(params)
    @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end


end