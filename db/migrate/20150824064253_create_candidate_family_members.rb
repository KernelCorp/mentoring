class CreateCandidateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :candidate_family_members do |t|
      t.belongs_to :candidate, index: true

      t.string :name
      t.string :gender
      t.string :age
      t.string :relation

      t.timestamps null: false
    end
  end
end
