class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @genre = Genre.find(@game.genre_id)
    @platform = Platform.find(@game.platform_id)
  end
end
