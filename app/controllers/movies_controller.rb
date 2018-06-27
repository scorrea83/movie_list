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
    if params[:movie][:genre_ids] && @movie.valid?
      @movie.save
      flash[:message] = "Movie successfuly added to Movie Lister!"
      redirect "/movies/#{@movie.id}"
    else
      flash[:message] = "You must select at least 1 movie genre from list." if !params[:movie][:genre_ids]
      flash[:alert] = "You must fill out all information fields" if @movie.invalid?
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

end