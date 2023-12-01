class ContactController < ApplicationController
  def index
    @contact = Contact.find(1)
  end
end
