class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @games = Game.where(:genre_id == @genre.id)
  end

  def self.search(search)
    where("lower(games.game_name) LIKE :search OR lower(genres.genre_name) LIKE :search lower(platforms.platform_name) LIKE :search", search: "%#{search.downcase}%").uniq
  end
end
