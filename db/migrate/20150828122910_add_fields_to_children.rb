class AddFieldsToChildren < ActiveRecord::Migration
  def change
    add_reference :children, :photo, index: true
    add_foreign_key :children, :photos
    add_column :children, :description, :text
    add_column :children, :is_friendly, :boolean, default: false
  end
end
