class GenresController < ApplicationController

  get '/genres' do
    if logged_in?
      erb :'genres/genres'
    else
      redirect '/users/login'
    end
  end


end