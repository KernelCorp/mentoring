class OrphanagesController < ApplicationController
  before_action :set_orphanage, only: [:show, :edit, :update, :destroy]

  # GET /orphanages
  # GET /orphanages.json
  def index
    @orphanages = Orphanage.all
  end

  # GET /orphanages/1
  # GET /orphanages/1.json
  def show
  end

  # GET /orphanages/new
  def new
    @orphanage = Orphanage.new
  end

  # GET /orphanages/1/edit
  def edit
  end

  # POST /orphanages
  # POST /orphanages.json
  def create
    @orphanage = Orphanage.new(orphanage_params)

    respond_to do |format|
      if @orphanage.save
        format.html { redirect_to @orphanage, notice: 'Orphanage was successfully created.' }
        format.json { render :show, status: :created, location: @orphanage }
      else
        format.html { render :new }
        format.json { render json: @orphanage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orphanages/1
  # PATCH/PUT /orphanages/1.json
  def update
    respond_to do |format|
      if @orphanage.update(orphanage_params)
        format.html { redirect_to @orphanage, notice: 'Orphanage was successfully updated.' }
        format.json { render :show, status: :ok, location: @orphanage }
      else
        format.html { render :edit }
        format.json { render json: @orphanage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orphanages/1
  # DELETE /orphanages/1.json
  def destroy
    @orphanage.destroy
    respond_to do |format|
      format.html { redirect_to orphanages_url, notice: 'Orphanage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orphanage
      @orphanage = Orphanage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orphanage_params
      params.require(:orphanage).permit(:name, :address)
    end
end
