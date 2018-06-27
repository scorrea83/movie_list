require 'spec_helper'

describe "Create A Movie", type: :feature do
  before do
    @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
    @genre1 = Genre.create(:title => "Action")
    @genre2 = Genre.create(:title => "Suspense")
    visit '/users/login'
    fill_in(:username, :with => "Pugalicious")
    fill_in(:password, :with => "test")
    click_button 'Log In'
  end

  context "given all movie attributes" do
    before do
      visit '/movies/new'
      fill_in('title', with: "Die Hard")
      fill_in('description', with: "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that weretaken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.")
      fill_in('release_year', with: 1988)
      select('Action', from: 'movie[genre_ids][]')
      select('Suspense', from: 'movie[genre_ids][]')

      click_button "Create Movie"
    end

    it "creates a new movie" do
      movie = Movie.find_by(title: "Die Hard")
      expect(movie).to be_an_instance_of(Movie)
      expect(movie.title).to eq("Die Hard")
      expect(Movie.all.count).to equal(1)
      expect(movie.genre_ids).to include(@genre1.id, @genre2.id)
    end

    it "redirects to new movie show page" do
      movie = Movie.find_by(title: "Die Hard")
      expect(page.current_path).to eq("/movies/#{movie.id}")
      expect(page.body).to include(movie.title)
      expect(page.body).to include(movie.description)
      expect(page.body).to include("#{movie.release_year}")
      expect(page.body).to include(@genre1.title, @genre2.title)
      expect(page).to have_content("Movie successfuly added to Movie Lister!")
    end
  end

  context "given blank movie attributes" do
    it "doesn't allow user to create new movie" do
      visit '/movies/new'
      click_button "Create Movie"

      expect(page.current_path).to eq("/movies/new")
      expect(page).to have_content("You must fill out all information fields")
      expect(page).to have_content("You must select at least 1 movie genre from list.")

    end
  end

end