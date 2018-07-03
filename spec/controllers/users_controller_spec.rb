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
    let (:attributes) do
      { :name => "Charlie",
        :username => "Pugalicious",
        :email => "charlie@email.com",
        :password => "test"
      }
    end

    let (:params) do
      { :username => "Pugalicious",
        :password => "test"
      }
    end

    it "loads page successfully" do
      get '/users/login'
      expect(last_response.status).to eq(200)
    end

    it "loads user show page upon successful login" do
      user = User.create(attributes)
      post '/users/login', params
      expect(last_response.location).to include("/users/#{user.id}")
    end

    it "is not allowed without username" do
      user = User.create(attributes)
      post '/users/login', params.except(:username)
      expect(last_response.location).to include("users/login")
    end

    it "is not allowed without password" do
      user = User.create(attributes)
      post '/users/login', params.except(:password)
      expect(last_response.location).to include("users/login")
    end

    it "doesn't display login page if user already logged in" do
      user = User.create(attributes)
      post '/users/login', params
      get '/users/login'
      expect(last_response.location).to include("/users/#{user.id}")
    end
  end

  describe "Logout" do

    let (:attributes) do
      { :name => "Charlie",
        :username => "Pugalicious",
        :email => "charlie@email.com",
        :password => "test"
      }
    end

    let (:params) do
      { :username => "Pugalicious",
        :password => "test"
      }
    end

    context "given user logged in" do
      it "lets user log out" do
        user = User.create(attributes)
        post '/users/login', params
        get '/users/logout'
        expect(last_response.location). to include("/users/login")
        expect(last_request.env['rack.session']['user_id']).to be_nil
      end

    end

    context "given user not logged in" do
      it "doesn't let user logout"
    end

  end

  describe "Show Action" do
    context "with user logged in" do
     before  do
        @user = User.create(:name => "Charlie", :username => "Pugalicious", :email => "charlie@email.com", :password => "test")
        @lists = @user.lists.create([{title: "Summer Watch List"}, {title: "Top 10"}, {title: "Date Night"}])

        visit '/users/login'
        fill_in(:username, :with => "Pugalicious")
        fill_in(:password, :with => "test")
        click_button 'Log In'
      end

      it "displays all user's movie lists" do
        visit "/users/#{@user.id}"

        expect(page.current_path).to eq("/users/1")
        expect(page.body).to include(@lists.map(&:title)[0])
        expect(page.body).to include(@lists.map(&:title)[1])
        expect(page.body).to include(@lists.map(&:title)[2])
      end

      it "displays user specific content if user's own page"
      it "doesn't display user specific content if viewing other user's show page"
    end

    context "with user not logged in" do
      it "doesn't allow user to view show page"
    end

  end

end