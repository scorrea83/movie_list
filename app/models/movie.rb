class Movie < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates_presence_of :description, :release_year

end