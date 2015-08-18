class AddCuratorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :curator_id, :integer
  end
end
