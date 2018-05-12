require 'spec_helper'

describe 'GenresController' do

  describe 'index page' do
    context "user logged in" do

      let(:params) do
        {:username => "Pugalicious", :password => "test"}
      end

      before  do
        @genre1 = Genre.create(:title => "Action")
        @genre2 = Genre.create(:title => "Drama")
        @user1 = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
        post '/users/login', params
      end

      it "lets user view genres index page" do
        visit '/genres'
        expect(page.body).to include(@genre1.title)
        expect(page.body).to include(@genre2.title)
      end

      it "index page contains links to each genre" do
        visit '/genres'
        expect(page).to have_link("#{@genre1.title}", href: "/genres/#{@genre1.id}")
        expect(page).to have_link("#{@genre2.title}", href: "/genres/#{@genre2.id}")
      end

    end

    context "user not logged in" do
      it "doesn't let user view genres index page"

    end

  end

end