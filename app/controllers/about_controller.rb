class AboutController < ApplicationController
  def index
    @abouts = About.all
  end
end
