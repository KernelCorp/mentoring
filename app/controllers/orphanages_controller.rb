class OrphanagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /orphanages
  def index
  end

  # GET /orphanages/1
  def show
  end

  # GET /orphanages/new
  def new
  end

  # GET /orphanages/1/edit
  def edit
  end

  # POST /orphanages
  def create
    if @orphanage.save
      redirect_to @orphanage, notice: 'Orphanage was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orphanages/1
  def update
    if @orphanage.update(orphanage_params)
      redirect_to @orphanage, notice: 'Orphanage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orphanages/1
  def destroy
    @orphanage.destroy
    redirect_to orphanages_url, notice: 'Orphanage was successfully destroyed.'
  end

  private
    def orphanage_params
      params.require(:orphanage).permit(:name, :address)
    end
end
