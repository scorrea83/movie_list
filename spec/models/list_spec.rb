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

  it "belongs to a user" do
    @user = User.create(:username => "Pugalicious", :name => "Charlie", :email => "charlie@email.com", :password => "test")
    @list = List.new(attributes)

    @user.lists << @list
    expect(@list.user).to eq(@user)
  end


end