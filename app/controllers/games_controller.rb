class GamesController < ApplicationController
  def index
    @games = Game.order(:game_name).page params[:page]
  end

  def show
    @game = Game.find(params[:id])
    @genre = Genre.find(@game.genre_id)
    @platform = Platform.find(@game.platform_id)
  end

  def search
    if params[:search].blank?
      redrect_to games_path and return
    else
      @parameter = params[:search].downcase
      @matchGames = Game.where("lower(game_name) LIKE ?", "%#{@parameter}%")
      @matchGenres = Genre.where("lower(genre_name) Like ?", "%#{@parameter}%")
      @matchPlatforms = Platform.where("lower(platform_name) LIKE ?", "%#{@parameter}%")
    end
  end
end
