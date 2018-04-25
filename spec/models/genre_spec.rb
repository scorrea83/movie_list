require 'spec_helper'

describe "Movie" do\
  before do
    @genre = Genre.create(:title => "action")
  end

  it "is invalid without a title" do
    expect(Genre.new(:title => nil)).not_to be_valid
  end

  it "is invalid without a unique title" do
    expect(Genre.new(:title => "action")).not_to be_valid
  end

  it "has many movies" do
    @adventure = Genre.create(:title => "adventure")
    @inception = Movie.create(title: "Inception", release_year: "2010", description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO.")
    @interstellar = Movie.create(title: "Interstellar", release_year: "2014", description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.")


    @adventure.movies << @inception
    @adventure.movies << @interstellar

    expect(@adventure.movies).to include(@inception)
    expect(@adventure.movies).to include(@interstellar)
  end




end