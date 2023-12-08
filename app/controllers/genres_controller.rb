class GenresController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @games = Game.where(:genre_id == @genre.id)

    add_breadcrumb(@genre.genre_name, genre_path(@genre))
  end

  def self.search(search)
    where("lower(games.game_name) LIKE :search OR lower(genres.genre_name) LIKE :search lower(platforms.platform_name) LIKE :search", search: "%#{search.downcase}%").uniq
  end

  def set_breadcrumbs
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Genres", genres_path)
  end
end
