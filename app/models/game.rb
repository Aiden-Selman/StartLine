class Game < ApplicationRecord
  has_one_attached :image

  paginates_per 12
end
