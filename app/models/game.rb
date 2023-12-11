class Game < ApplicationRecord
  belongs_to :genre
  belongs_to :platform

  validates :game_name, :rating, :release_date, :price, :description, presence: true
  validates :game_name, uniqueness: true
  validates :price, numericality: true

  has_one_attached :image

  paginates_per 10
end
