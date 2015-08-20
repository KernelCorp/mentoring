class MainController < ApplicationController
  before_action :authenticate_user!

  def index
    render layout: false
  end
end