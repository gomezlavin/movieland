class Movie < ActiveRecord::Base
  attr_accessible :imdbID, :title, :rating

  validates :imdbID, presence: true, uniqueness: true
  validates :title, presence: true
end
