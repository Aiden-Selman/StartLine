class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  def initialize_session
    session[:session_cart] ||= []
  end

  def cart
    Game.find(session[:session_cart])
  end
end
