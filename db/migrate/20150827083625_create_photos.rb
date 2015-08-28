class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      t.attachment :image
      t.references :album, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :photos, :albums
    add_foreign_key :photos, :users
  end
end
