class MeetingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :meeting

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.accessible_by(current_ability, :read)
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @children = current_user.children
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    #@meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Новая встреча назначена.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Встреча была успешно изменена.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Встреча была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  def reopen
    if @meeting.reopen
      flash[:notice] = 'Встреча была успешно переназначена.'
    else
      flash[:notice] = 'Встречу не удалось переназначить.'
      flash[:error] = @meeting.errors[:name].first
    end
    redirect_to meetings_path
  end

  def reject
    if @meeting.reject
      flash[:notice] = current_user.has_role?(:mentor) ? 'Вы отказались от встречи.' : 'Вы отклонили встречу.'
    else
      flash[:notice] = 'Встречу не удалось отклонить.'
      flash[:error] = @meeting.errors[:name].first
    end
    redirect_to meetings_path
  end

  private
    def meeting_params
      params.require(:meeting).permit(:date, :state, :child_id, :mentor_id)
    end
end
