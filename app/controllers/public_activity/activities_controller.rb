class PublicActivity::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @activities = @activities.order('created_at DESC').limit(20)
  end
end
