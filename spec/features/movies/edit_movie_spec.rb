require 'spec_helper'

describe "Edit A Movie", type: :feature do
  context "with user logged in" do
    before do
    @genre1 = Genre.create(:title => "Action")
    @genre2 = Genre.create(:title => "Suspense")
    @movie = Movie.create(:title => "Die Hard", :description => "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.", :release_year => 1988)
    @movie.genres << @genre1
    @movie.genres << @genre2
    binding.pry
    visit '/users/login'
    fill_in(:username, :with => "Pugalicious")
    fill_in(:password, :with => "test")
    click_button 'Log In'

    end
    context "given success" do
      before do
        #visit "/movies/#{@movie.id}/edit"
        #fill_in('title', with: "Die Hard, A Christmas Story")
        #click_button "Save Changes"
      end

      it "edits a movie"
      it "redirects to movie show page after edit"

    end

    context "given failure" do
      it "doesn't edit movie with blank features"
			it "doesn't edit movie without genre(s) selected"
      it "doesn't allow user to edit title to that of another existing movie"

    end

  end

  context "with user not logged in" do
    it "doesn't allow user to view edit page"

  end

end