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
        expect(page).to have_link("#{@movie1.title}", href: "/movies/#{@movie1.id}")
        expect(page).to have_link("#{@movie2.title}", href: "/movies/#{@movie2.id}")
      end

    end

    context "user not logged in" do
      it "doesn't let user view movies index page" do
        get '/movies'
        expect(last_response.location).to include('/users/login')
      end
    end

  end

  describe "show action" do

    context "user logged in" do
      before  do
        @genre = Genre.create(:title => "Action")
        @movie = Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)
        @genre.movies << @movie
        @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
        visit '/users/login'
        fill_in(:username, :with => "Pugalicious")
        fill_in(:password, :with => "test")
        click_button 'Log In'
      end

      it "lets user view movie show page" do
        visit "/movies/#{@movie.id}"
        expect(page.body).to include(@movie.title)
      end

      it "displays a movie's description" do
        visit "/movies/#{@movie.id}"
        expect(page.body).to include(@movie.description)
      end

      it "displays a movie's release_year" do
        visit "/movies/#{@movie.id}"
        expect(page.body).to include("#{@movie.release_year}")
      end

      it "contains link to movie's edit page" do
        visit "/movies/#{@movie.id}"
        expect(page).to have_link("Edit Movie Info", href: "/movies/#{@movie.id}/edit")
      end

      it "displays movie genres" do
        visit "/movies/#{@movie.id}"
        expect(page.body).to include(@genre.title)
      end
    end

    context "user not logged in" do
      before do
        @movie = Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)
      end

      it "doesn't let user view movies index page" do
        get "/movies/#{@movie.id}"
        expect(last_response.location).to include('/users/login')

      end

    end
  end

  describe "new action" do

    context "user logged in" do
      before  do
        @genre1 = Genre.create(:title => "Action")
        @genre2 = Genre.create(:title => "Horror")
        @genre3 = Genre.create(:title => "Comedy")
        @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
        visit '/users/login'
        fill_in(:username, :with => "Pugalicious")
        fill_in(:password, :with => "test")
        click_button 'Log In'
      end

      it "page displays genres dropdown list" do
        visit '/movies/new'
        expect(page).to have_select('movie[genre_ids][]', with_options: ['Action', 'Horror', 'Comedy'])
        expect(page).to have_css("option", :count => 3)
      end

      it "doesn't allow user to create already existing movie" do
        Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)

        visit '/movies/new'
        fill_in('title', with: "Die Hard")
        fill_in('description', with: "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that weretaken   hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.")
        fill_in('release_year', with: 1988)
        select('Action', from: 'movie[genre_ids][]')

        click_button "Create Movie"

        expect(Movie.all.count).to eq(1)
        expect(page.current_path).to eq("/movies/new")
      end
    end

    context "user not logged in" do
      it "doesn't allow user to view new movie page" do
        get '/movies/new'
        expect(last_response.location).to include('/users/login')
      end
    end
  end

end