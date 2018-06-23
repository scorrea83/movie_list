require 'spec_helper'

describe "Edit A Movie", type: :feature do
  context "with user logged in" do
    before do
    @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
    @genre1 = Genre.create(:title => "Action")
    @genre2 = Genre.create(:title => "Suspense")
    @movie = Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)
    @movie.genres << @genre1
    @movie.genres << @genre2
    visit '/users/login'
    fill_in(:username, :with => "Pugalicious")
    fill_in(:password, :with => "test")
    click_button 'Log In'
    end

    context "given success" do
      before do
        @genre3 = Genre.create(:title => "Comedy")
        visit "/movies/#{@movie.id}/edit"
      end

      it "changes a movie title" do
        fill_in('title', with: "Die Hard, A Christmas Story")
        click_button "Save Changes"
        movie = Movie.find(@movie.id)

        expect(movie.title).to eq("Die Hard, A Christmas Story")
        expect(page.current_path).to eq("/movies/#{movie.id}")
      end

      it "changes a movie's genres" do
        unselect('Suspense', from: 'movie[genre_ids][]')
        select('Comedy', from: 'movie[genre_ids][]')
        click_button "Save Changes"
        movie = Movie.find(@movie.id)

        expect(page.current_path).to eq("/movies/#{movie.id}")
        expect(movie.genre_ids).to include(@genre1.id, @genre3.id)
        expect(movie.genre_ids).to_not include(@genre2.id)
      end
    end

    context "given failure" do
      before do
        visit "/movies/#{@movie.id}/edit"
      end

      it "doesn't edit movie with blank features" do
        fill_in('title', with: "")
        fill_in('description', with: "")
        click_button "Save Changes"
        movie = Movie.find(@movie.id)

        expect(movie.title).to eq(@movie.title)
        expect(movie.description).to eq(@movie.description)
        expect(page.current_path).to eq("/movies/#{@movie.id}/edit")
      end

      it "doesn't edit movie without genre(s) selected" do
        unselect('Suspense', from: 'movie[genre_ids][]')
        unselect('Action', from: 'movie[genre_ids][]')
        click_button "Save Changes"
        movie = Movie.find(@movie.id)

        expect(page.current_path).to eq("/movies/#{@movie.id}/edit")
        expect(movie.genre_ids).to include(@genre1.id, @genre2.id)
			end

      it "doesn't allow user to edit title to that of another existing movie" do
        @movie2 = Movie.create(:title => "Die Hard 2", :description => "John McClane kicks terrorist butt, while on holiday.", :release_year => 1988)
        @movie2.genres << @genre1
        fill_in('title', with: "Die Hard 2")
        click_button "Save Changes"
        movie = Movie.find(@movie.id)

        expect(movie.title).to eq("Die Hard")
        expect(page.current_path).to eq("/movies/#{@movie.id}/edit")
      end

    end

  end

  context "with user not logged in" do
    it "doesn't allow user to view edit page" do
      @movie = Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)
        visit "/movies/#{@movie.id}/edit"

        expect(page.current_path).to include('/users/login')
    end

  end

end