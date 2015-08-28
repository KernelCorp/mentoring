class AlbumsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
    @photos = @album.photos.persisted
  end

  def new
  end

  def edit
  end

  def create
    if @album.save
      redirect_to @album, notice: 'Новый альбом добавлен.'
    else
      render :new, notice: 'Не удалось добавить альбом.', error: @album.errors[:name].first
    end
  end

  def update
    if @album.update(album_params)
      redirect_to @album, notice: 'Альбом был успешно сохранён.'
    else
      render :edit, notice: 'Альбом не удалось изменить.', error: @album.errors[:name].first
    end
  end

  def destroy
    if @album.destroy
      flash[:notice] = 'Альбом был успешно удалён.'
    else
      flash[:notice] = 'Альбом не удалось удалить.'
      flash[:error] = @album.errors[:name].first
    end

    redirect_to albums_url
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :user_id)
    end
end
