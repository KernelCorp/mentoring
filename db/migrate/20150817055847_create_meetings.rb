class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :date
      t.string :state
      t.references :child, index: true
      t.integer :mentor_id

      t.timestamps null: false
    end
    add_foreign_key :meetings, :children
  end
end
