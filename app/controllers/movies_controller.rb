class MoviesController < ApplicationController

  get '/movies' do
    if logged_in?
      erb :'movies/movies'
    else
      redirect '/users/login'
    end
  end

  get '/movies/new' do
      erb :'movies/new_movie'
  end

  post '/movies'do
    @movie = Movie.new(params[:movie])
    if @movie.valid?
      @movie.save
      redirect "/movies/#{@movie.id}"
    else
      erb :'/movies/new'
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