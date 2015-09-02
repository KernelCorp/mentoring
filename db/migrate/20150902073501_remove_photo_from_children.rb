class RemovePhotoFromChildren < ActiveRecord::Migration
  def change
    remove_foreign_key :children, :photo
    remove_reference :children, :photo, index: true
  end
end
