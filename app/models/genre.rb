class Genre < ApplicationRecord
  has_many :games

  validates :genre_name, presence: true
  validates :genre_name, uniqueness: true

  paginates_per 12
end
