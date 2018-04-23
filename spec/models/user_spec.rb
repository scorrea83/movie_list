require 'spec_helper'

describe 'User' do

  before do
    @user = User.create(:username => "Pugalicious", :name => "Charlie", :email => "charlie@email.com", :password => "test")
  end

  it 'has a secure password' do
    expect(@user.authenticate("dog")).to eq(false)
    expect(@user.authenticate("test")).to eq(@user)
  end

  it "is invalid without a name" do
    @user2 = User.create(:username => "Pugalicious", :email => "charlie@email.com", :password => "test")
    expect(@user2).not_to be_valid
  end

  it "is invalid without a username" do
    @user2 = User.create(:name => "Charlie", :email => "charlie@email.com", :password => "test")
    expect(@user2).not_to be_valid
  end

  it "is invalid without an email" do
    @user2 = User.create(:username => "Pugalicious", :name => "Charlie", :email => nil , :password => "test")
    expect(@user2).not_to be_valid
  end

  it "must have unique username to be valid" do
    @user2 = User.create(:username => "Pugalicious", :name => "Charlie", :email => "charlie@email.com" , :password => "test")
    expect(@user2).not_to be_valid
  end

  it "must have unique email to be valid" do
    @user2 = User.create(:username => "user2", :name => "Charlie", :email => "charlie@email.com" , :password => "test")
    expect(@user2).not_to be_valid
  end

end