class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  validates :title, presence: true, uniqueness: true
end