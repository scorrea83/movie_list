require 'spec_helper'

describe 'List' do

  let(:attributes) do
    {
      title: "Watchlist",
      description: "movies to watch"
    }
  end

  let(:missing_title) { attributes.except(:title) }

  it "is invalid without a title" do
    expect(List.new(missing_title)).not_to be_valid
  end

  it "belongs to a user" do
    @user = User.create(:username => "Pugalicious", :name => "Charlie", :email => "charlie@email.com", :password => "test")
    @list = List.new(attributes)

    @user.lists << @list
    expect(@list.user).to eq(@user)
  end

  it "has many movies" do
    @watchlist = List.create(attributes)
    @inception = Movie.create(title: "Inception", release_year: "2010", description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO.")
    @interstellar = Movie.create(title: "Interstellar", release_year: "2014", description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.")


    @watchlist.movies << @inception
    @watchlist.movies << @interstellar

    expect(@watchlist.movies).to include(@inception)
    expect(@watchlist.movies).to include(@interstellar)
  end


end