require 'spec_helper'

describe "Movie" do\
  before do
    @genre = Genre.create(:title => "action")
  end

  it "is invalid without a title" do
    expect(Genre.new(:title => nil)).not_to be_valid
  end



end