require 'spec_helper'

describe 'User' do

  before do
    @user = User.create(:username => "Pugalicious", :name => "Charlie", :email => "charlie@email.com", :password => "test")
  end

  it 'has a secure password' do
    expect(@user.authenticate("dog")).to eq(false)
    expect(@user.authenticate("test")).to eq(@user)
  end

end