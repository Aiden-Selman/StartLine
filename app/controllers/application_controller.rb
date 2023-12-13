class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart
  helper_method :breadcrumbs

  def initialize_session
    session[:shopping_cart] ||= []
  end

  def cart
    Game.find(session[:shopping_cart])
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  # Add custom flash types
  # add_flash_types :warning, :info
end