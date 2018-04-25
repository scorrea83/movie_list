require 'spec_helper'

describe 'Movie' do
  let(:attributes) do
    {
      title: "Inception",
      release_year: "2010",
      description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO."
    }
  end

  let(:missing_title) { attributes.except(:title) }
  let(:missing_description) { attributes.except(:description) }
  let(:missing_release_year) { attributes.except(:release_year) }

  it "is invalid without a title" do
    expect(Movie.new(missing_title)).not_to be_valid
  end

  it "is invalid with title that already exists" do
    @inception = Movie.create(attributes)
    @movie = Movie.new(attributes)
    expect(@movie).not_to be_valid
  end

  it "is invalid without a description" do
    expect(Movie.new(missing_description)).not_to be_valid
  end

  it "is invalid without a release year" do
    expect(Movie.new(missing_release_year)).not_to be_valid
  end

  it "has many lists" do
    @watchlist = List.create(:title => "watchlist")
    @favorites = List.create(:title => "favorites")
    @inception = Movie.create(attributes)

    @inception.lists << @watchlist
    @inception.lists << @favorites

    expect(@inception.lists).to include(@watchlist)
    expect(@inception.lists).to include(@favorites)
  end

  it "has many genres" do
    @adventure = Genre.create(:title => "Adventure")
    @scifi = Genre.create(:title => "SciFi")
    @inception = Movie.create(attributes)

    @inception.genres << @adventure
    @inception.genres << @scifi

    expect(@inception.genres).to include(@adventure)
    expect(@inception.genres).to include(@scifi)
  end



end