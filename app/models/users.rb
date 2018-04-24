class User < ActiveRecord::Base
  has_secure_password
  has_many :lists

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email

end