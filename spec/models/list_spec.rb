require 'spec_helper'

describe 'List' do

  let(:attributes) do
    {
      title: "Watchlist",
      description: "movies to watch"
    }
  end

  let(:missing_title) { attributes.except(:title) }

  it "is invalid without a title" do
    expect(List.new(missing_title)).not_to be_valid
  end


end