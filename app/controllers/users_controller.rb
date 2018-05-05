class UsersController < ApplicationController

  get '/users/signup' do
    erb :"users/new_user"
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



end