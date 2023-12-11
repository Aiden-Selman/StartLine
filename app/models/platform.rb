class Platform < ApplicationRecord
  has_many :games

  validates :platform_name, presence: true

  paginates_per 10
end
