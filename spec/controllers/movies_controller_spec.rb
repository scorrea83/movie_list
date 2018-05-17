require 'spec_helper'

describe 'MoviesController' do

  describe "index action" do

    context "user logged in" do
      it "lets user view movies index page"

      it "index contains links to each movie"

    end

    context "user not logged in" do
      it "doesn't let user view genres index page"
    end

  end


end