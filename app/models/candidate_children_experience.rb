# == Schema Information
#
# Table name: candidate_children_experiences
#
#  id                    :integer          not null, primary key
#  candidate_id          :integer
#  organization_name     :string
#  organization_contacts :string
#  position              :string
#  functions             :text
#  children_age          :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class CandidateChildrenExperience < ActiveRecord::Base
  belongs_to :candidate
end
