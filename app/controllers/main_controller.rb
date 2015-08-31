class MainController < ApplicationController
  def index
    render layout: false
  end

  def friendship
    @children = Child.want_to_be_friends.order(id: :asc)

    render layout: false
  end
end