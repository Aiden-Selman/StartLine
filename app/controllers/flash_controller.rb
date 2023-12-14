class FlashController < ApplicationController
  def show
    # flash.alert = 'usage limit exceeded!'
    # flash.notice = 'the post was successfully saved'

    # Using the :warning flash type defined in ApplicationController
    # in the view
    # <%= warning %>
    # redirect_to root_path, warning: "Incomplete profiles"
  end
end