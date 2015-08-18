class CreateOrphanages < ActiveRecord::Migration
  def change
    create_table :orphanages do |t|
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end
