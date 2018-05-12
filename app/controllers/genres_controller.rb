class GenresController < ApplicationController

  get '/genres' do
    erb :'genres/genres'
  end


end