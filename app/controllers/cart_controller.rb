class CartController < ApplicationController
  def create
    # add params[:id] to cart
    # the ollger will show in the rails serve, super useful for debugging!!
    logger.debug("Adding #{params[:id]} to cart.")
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      game = Game.find(id)
      flash[:notice] = " ➕ #{game.game_name} added to cart."
    end
    # session[:shopping_cart] << id
    redirect_to root_path
  end

  def destroy
    # remove params[:id] from cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    game = Game.find(id)

    flash[:notice] = "➖ #{game.game_name} removed from cart."
    redirect_to root_path
  end
end
