require 'spec_helper'

describe 'UsersController' do

  describe 'Signup Page' do

    let (:params) do
      { :name => "Charlie",
        :username => "Pugalicious",
        :email => "charlie@email.com",
        :password => "test"
      }
    end

    it 'loads successfully' do
      get '/users/signup'
      expect(last_response.status).to eq(200)
     end

    it 'directs user to /user/show page upon successful signup' do
      post '/users/signup', params
      user = User.last
      expect(last_response.location).to include("/users/#{user.id}")
    end

    it "doesn't allow user to signup without username" do
      post '/users/signup', params.except(:username)
      expect(last_response.location).to include("users/signup")
    end

    it "doesn't allow user to signup without :email" do
      post '/users/signup', params.except(:email)
      expect(last_response.location).to include("users/signup")
    end

    it "doesn't allow user to signup without :password" do
      post '/users/signup', params.except(:password)
      expect(last_response.location).to include("users/signup")
    end

    it "doesn't allow user to signup without :name" do
      post '/users/signup', params.except(:name)
      expect(last_response.location).to include("users/signup")
    end

    it "doesn't let a logged in user view the signup page" do
      post '/users/signup', params
      user = User.last
      session = {}
      session[:user_id] = user.id
      get '/users/signup'
      expect(last_response.location).to include("/users/#{user.id}")
    end

  end

  describe 'login' do

    let (:params) do
      { :username => "Pugalicious",
        :password => "test"
      }
    end

    it "loads page successfully" do
      get '/users/login'
      expect(last_response.status).to eq(200)
    end

    # loads user show page upon succesful login
    # doesn't allow login without username
    # doesn't allow login without password
    # doesn't let logged in user view login page



  end

end