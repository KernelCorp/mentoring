class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :albums, :users
  end
end
