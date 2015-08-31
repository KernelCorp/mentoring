class ChildrenController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /children
  def index
  end

  # GET /children/1
  def show
    @next_child = children_for_friendship.where('id > ?', @child.id).first
    @previous_child = children_for_friendship.where('id < ?', @child.id).last
  end

  # GET /children/new
  def new
  end

  # GET /children/1/edit
  def edit
  end

  # POST /children
  def create
    if @child.save
      redirect_to @child, notice: 'Child was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /children/1
  def update
    if @child.update(child_params)
      redirect_to @child, notice: 'Child was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /children/1
  def destroy
    @child.destroy
    redirect_to children_url, notice: 'Child was successfully destroyed.'
  end

  private
    def child_params
      params.require(:child).permit(:first_name, :last_name, :middle_name, :birthdate, :orphanage_id, :mentor_id)
    end
end
