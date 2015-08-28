class PhotosController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /photos/1
  def show
    @album = @photo.album

    ordered_photos = @album.photos.order(id: :asc)
    @next_photo = ordered_photos.where('id > ?', @photo.id).first
    @previous_photo = ordered_photos.where('id < ?', @photo.id).last

    @comments = @photo.comments
  end

  # POST /photos
  def create
    album = @photo.album
    path = album.present? ? album_path(album) : albums_path
    respond_to do |format|
      if @photo.save
        format.html { redirect_to path, notice: 'Photo was successfully created.' }
        format.json { render json: { message: 'success', fileID: @photo.id }, status: 200 }
      else
        format.html { redirect_to path }
        format.json { render json: { error: @photo.errors.full_messages.join(',')}, status: 400 }
      end
    end
  end

  # DELETE /photos/1
  def destroy
    album = @photo.album
    path = album.present? ? album_path(album) : albums_path
    @photo.destroy
    redirect_to path, notice: 'Photo was successfully destroyed.'
  end

  private
    def photo_params
      params.require(:photo).permit(:description, :image, :album_id, :user_id)
    end
end
