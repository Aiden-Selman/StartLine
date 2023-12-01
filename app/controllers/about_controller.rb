class AboutController < ApplicationController
  def index
    @about = About.find(1)
  end
end
