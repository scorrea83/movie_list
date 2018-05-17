require 'spec_helper'

describe 'MoviesController' do

  describe "index action" do

    context "user logged in" do

      before do
        @movie1 = Movie.create(title: "Inception", release_year: "2010", description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO.")
        @movie2 = Movie.create(title: "Interstellar", release_year: "2014", description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.")
        @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
        visit '/users/login'
        fill_in(:username, :with => "Pugalicious")
        fill_in(:password, :with => "test")
        click_button 'Log In'
      end

      it "lets user view movies index page" do
        visit '/movies'
        expect(page.body).to include(@movie1.title)
        expect(page.body).to include(@movie2.title)
      end

      it "index contains links to each movie" do
        visit '/movies'
        expect(page.body).to have_link("#{@movie1.title}", href: "/movies/#{@movie1.id}")
        expect(page.body).to have_link("#{@movie2.title}", href: "/movies/#{@movie2.id}")
      end

    end

    context "user not logged in" do
      it "doesn't let user view movies index page"
    end

  end


end