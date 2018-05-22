class MoviesController < ApplicationController

  get '/movies' do
    if logged_in?
      erb :'movies/movies'
    else
      redirect '/users/login'
    end
  end

  get '/movies/:id' do
    if logged_in?
      @movie = Movie.find(params[:id])
      erb :'movies/show_movie'
    else
      redirect '/users/login'
    end
  end

end