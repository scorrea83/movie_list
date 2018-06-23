class MoviesController < ApplicationController

  get '/movies' do
    if logged_in?
      erb :'movies/movies'
    else
      redirect '/users/login'
    end
  end

  get '/movies/new' do
    if logged_in?
      erb :'movies/new_movie'
    else
      redirect '/users/login'
    end
  end

  post '/movies' do
    @movie = Movie.new(params[:movie])
    if @movie.valid?
      @movie.save
      redirect "/movies/#{@movie.id}"
    else
      redirect '/movies/new'
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

  get '/movies/:id/edit' do
    if logged_in?
      @movie = Movie.find(params[:id])
      erb :'movies/edit_movie'
    else
      redirect '/users/login'
    end
  end

  patch '/movies/:id' do
    @movie = Movie.find(params[:id])
    if params[:movie][:genre_ids] && @movie.update(params[:movie])
      redirect "/movies/#{@movie.id}"
    else
      redirect "/movies/#{@movie.id}/edit"
    end
  end

end