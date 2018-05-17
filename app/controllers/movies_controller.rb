class MoviesController < ApplicationController

  get '/movies' do
    erb :'movies/movies'
  end

end