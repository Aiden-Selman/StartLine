class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  def initialize_session
    session[:shopping_cart] ||= []
  end

  def cart
    Game.find(session[:shopping_cart])
  end
end
