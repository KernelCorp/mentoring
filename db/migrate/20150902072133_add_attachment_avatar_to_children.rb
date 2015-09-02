class AddAttachmentAvatarToChildren < ActiveRecord::Migration
  def self.up
    change_table :children do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :children, :avatar
  end
end
