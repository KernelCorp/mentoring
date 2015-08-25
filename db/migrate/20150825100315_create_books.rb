class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.integer :priority, default: 2
      t.references :owner, references: :user, index: true
      t.attachment :file

      t.timestamps null: false
    end

    add_foreign_key :books, :users, column: :owner_id
  end
end
