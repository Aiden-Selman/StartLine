class Game < ApplicationRecord
  has_one_attached :image

  paginates_per 10
end
