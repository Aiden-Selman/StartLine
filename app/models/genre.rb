class Genre < ApplicationRecord
  has_many :games

  validates :genre_name, presence: true

  paginates_per 10
end
