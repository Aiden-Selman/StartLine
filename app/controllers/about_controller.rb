class AboutController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @abouts = About.all
  end

  def set_breadcrumbs
    add_breadcrumb("Home", root_path)
    add_breadcrumb("About", about_path)
  end
end
