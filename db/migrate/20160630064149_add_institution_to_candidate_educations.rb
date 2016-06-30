class AddInstitutionToCandidateEducations < ActiveRecord::Migration
  def change
    add_column :candidate_educations, :institution, :string
  end
end
