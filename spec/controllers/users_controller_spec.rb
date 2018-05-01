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

    # displays user show page if signup successful
    # doesn't allow user to signup without username
    # doesn't allow user to signup without email
    # doesn't allow user to signup without password
    # doesn't allow user to signup without name
  end

end