class AddRussianCitizenshipToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :russian_citizenship, :boolean
    remove_column :candidates, :nationality, :string
  end
end
