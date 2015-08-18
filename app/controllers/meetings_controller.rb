class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_roles
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :reject, :reopen]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = []

    if current_user.has_role? :admin
      @meetings += Meeting.all
    elsif current_user.has_role? :curator
      @meetings += Meeting.joins(:mentor).where(users: {curator_id: current_user.id})
    elsif current_user.has_role? :mentor
      @meetings += current_user.meetings.all
    end

  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @children = current_user.children
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

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
    @meeting.reopen!
    flash[:notice] = 'Встреча была успешно переназначена.'
    redirect_to meetings_path
  end

  def reject
    @meeting.reject!
    flash[:notice] = current_user.has_role?(:mentor) ? 'Вы отказались от встречи.' : 'Вы отклонили встречу.'
    redirect_to meetings_path
  end

  private
    def check_roles
      unless current_user.has_any_role? :mentor, :curator, :admin
        redirect_to root_path
      end
    end

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:date, :state, :child_id, :mentor_id)
    end
end
