class GenresController < ApplicationController

  get '/genres' do
    if logged_in?
      erb :'genres/genres'
    else
      redirect '/users/login'
    end
  end

  get '/genres/:id' do
    if logged_in?
      @genre = Genre.find(params[:id])
      erb :'genres/show_genre'
    else
      redirect '/users/login'
    end
  end


end