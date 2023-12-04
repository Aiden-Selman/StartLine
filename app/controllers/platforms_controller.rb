class PlatformsController < ApplicationController
  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.find(params[:id])
  end

  def self.search(search)
    where("lower(games.game_name) LIKE :search OR lower(genres.genre_name) LIKE :search lower(platforms.platform_name) LIKE :search", search: "%#{search.downcase}%").uniq
  end
end
