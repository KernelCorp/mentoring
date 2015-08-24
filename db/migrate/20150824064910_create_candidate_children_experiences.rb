class CreateCandidateChildrenExperiences < ActiveRecord::Migration
  def change
    create_table :candidate_children_experiences do |t|
      t.belongs_to :candidate, index: true

      t.string :organization_name
      t.string :organization_contacts
      t.string :position
      t.text :functions
      t.string :children_age

      t.timestamps null: false
    end
  end
end
