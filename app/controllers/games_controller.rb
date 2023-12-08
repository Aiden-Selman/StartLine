class GamesController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @games = Game.order(:game_name).page params[:page]
  end

  def show
    @game = Game.find(params[:id])
    @genre = Genre.find(@game.genre_id)
    @platform = Platform.find(@game.platform_id)

    add_breadcrumb(@game.game_name, game_path(@game))
  end

  def search
    if params[:search].blank?
      redrect_to games_path and return
    else
      @parameter = params[:search].downcase
      @matchGames = Game.where("lower(game_name) LIKE ?", "%#{@parameter}%").page(params[:page]).per(12)
      @matchGenres = Genre.where("lower(genre_name) Like ?", "%#{@parameter}%").page(params[:page]).per(12)
      @matchPlatforms = Platform.where("lower(platform_name) LIKE ?", "%#{@parameter}%").page(params[:page]).per(12)
    end
  end

  def set_breadcrumbs
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Games", games_path)
  end
end
