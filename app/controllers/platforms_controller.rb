class PlatformsController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.find(params[:id])

    add_breadcrumb(@platform.platform_name, platform_path(@platform))
  end

  def self.search(search)
    where("lower(games.game_name) LIKE :search OR lower(genres.genre_name) LIKE :search lower(platforms.platform_name) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  def set_breadcrumbs
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Platform", platforms_path)
  end
end
