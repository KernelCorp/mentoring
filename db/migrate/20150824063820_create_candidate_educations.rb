class CreateCandidateEducations < ActiveRecord::Migration
  def change
    create_table :candidate_educations do |t|
      t.belongs_to :candidate, index: true

      t.string :education
      t.date :start_date
      t.date :end_date
      t.string :specialty

      t.timestamps null: false
    end
  end
end
