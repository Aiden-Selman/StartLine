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
    # Order.create(user_id: current_user.id, game_id: session[:shopping_cart][0], quantity: params[:quantity], province_id: params[:selected_province_id], total_price: params[:finaltotal])
    # flash[:notice] = "Order created successfully!"
    redirect_to root_path
  end
end
