class Genre < ActiveRecord::Base

  validates :title, presence: true
end