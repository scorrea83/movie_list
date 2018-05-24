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

  end

  context "with user not logged in" do
  end


end