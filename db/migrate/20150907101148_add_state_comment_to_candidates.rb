class AddStateCommentToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :state_comment, :text
  end
end
