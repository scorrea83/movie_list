class Movie < ActiveRecord::Base
  has_many :movie_lists
  has_many :lists, through: :movie_lists
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  validates :title, presence: true, uniqueness: true
  validates_presence_of :description, :release_year

end