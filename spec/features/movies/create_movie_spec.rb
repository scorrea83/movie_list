require 'spec_helper'

describe "Create A Movie", type: :feature do
  context "with user logged in" do
    before do
      @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
      visit '/users/login'
      fill_in(:username, :with => "Pugalicious")
      fill_in(:password, :with => "test")
      click_button 'Log In'
    end

    context "allows user to create movie" do
      before do
      #visit new movie page
      #fill in form inputs movie[title], movie[release_year], movie[description]
      #click on "Create Movie" button
      end

      it "creates a new movie"
        #movie = Movie.find_by(name: "")
        #expect movie to be instance of Movie
        #Movie.all.count should be 1
      it "redirects to new movie show page"
        #user should be redirected to movie show page
        #expect page.current_path to equal "/movies/#{@movie.id}"
        #page should have movie title
        #page should have movie description
        #page should have movie release_year
    end

    context "given blank movie attributes" do
      it "doesn't allow user to create new movie"
    end
  end

  context "with user not logged in" do
    it "doesn't allow user to create new movie"
  end


end