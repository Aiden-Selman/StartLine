class CheckoutController < ApplicationController
  def index
    @cart = session[:shopping_cart]
    @provinces = Province.all()
    @games = []
    @cart.each do |game|
      @games << Game.find(game)
    end
    @total_cost = 0
    @games.each do |game|
      @total_cost += game.price / 100
    end
  end

  def create
    flash[:notice] = params
    redirect_to root_path
  end
end
