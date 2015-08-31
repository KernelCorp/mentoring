class MainController < ApplicationController
  def index
  end

  def about
  end

  def friendship
    @children = Child.want_to_be_friends.order(id: :asc)
  end
end