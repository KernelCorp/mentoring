class AddFieldsToReports < ActiveRecord::Migration
  def change
    rename_column :reports, :text, :aim
    add_column :reports, :duration, :integer
    add_column :reports, :short_description, :text
    add_column :reports, :result, :text
    add_column :reports, :feelings, :text
    add_column :reports, :questions, :text
    add_column :reports, :next_aim, :text
    add_column :reports, :other_comments, :text
  end
end
