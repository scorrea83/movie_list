class List < ActiveRecord::Base
  belongs_to :user
  has_many :movie_lists
  has_many :movies, through: :movie_lists

  validates_presence_of :title

end