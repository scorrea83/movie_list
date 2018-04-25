require 'spec_helper'

describe 'Movie' do
  let(:attributes) do
    {
      title: "Inception",
      release_year: "2010",
      description: "A thief, who steals corporate secrets through the use of dream-sharing technology, is given the inverse task of planting an idea into the mind of a CEO."
    }
  end

  let(:missing_title) { attributes.except(:title) }

  it "is invalid without a title" do
    expect(Movie.new(missing_title)).not_to be_valid
  end



end