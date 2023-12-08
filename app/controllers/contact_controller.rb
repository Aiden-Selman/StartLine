class ContactController < ApplicationController
  before_action :set_breadcrumbs

  def index
    @contacts = Contact.all
  end

  def set_breadcrumbs
    add_breadcrumb("Home", root_path)
    add_breadcrumb("Contact", contact_path)
  end
end
