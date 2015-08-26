class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, index: true
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end

    add_foreign_key :comments, :users
  end
end
