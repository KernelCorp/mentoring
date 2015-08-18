class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :text
      t.string :state
      t.references :meeting, index: true

      t.timestamps null: false
    end
    add_foreign_key :reports, :meetings
  end
end
