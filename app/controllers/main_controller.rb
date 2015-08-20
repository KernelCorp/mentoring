class MainController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def main
    render layout: false
  end
end