class MeetingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /meetings
  def index
  end

  # GET /meetings/1
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
  def create
    if @meeting.save
      redirect_to @meeting, notice: 'Новая встреча назначена.'
    else
      render :new, notice: 'Не удалось назначить встречу.', error: @meeting.errors[:name].first
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      redirect_to @meeting, notice: 'Встреча была успешно изменена.'
    else
      render :edit, notice: 'Встречу не удалось изменить.', error: @meeting.errors[:name].first
    end
  end

  # DELETE /meetings/1
  def destroy
    if @meeting.destroy
      flash[:notice] = 'Встреча была успешно удалена.'
    else
      flash[:notice] = 'Встречу не удалось удалить.'
      flash[:error] = @meeting.errors[:name].first
    end

    redirect_to meetings_url
  end

  # GET /meetings/1/reopen
  def reopen
    if @meeting.reopen and @meeting.save
      flash[:notice] = 'Встреча была успешно переназначена.'
    else
      flash[:notice] = 'Встречу не удалось переназначить.'
      flash[:error] = @meeting.errors[:name].first
    end

    redirect_to meetings_path
  end

  # GET /meetings/1/reject
  def reject
    if @meeting.reject and @meeting.save
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
