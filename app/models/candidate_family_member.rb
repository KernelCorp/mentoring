# == Schema Information
#
# Table name: candidate_family_members
#
#  id           :integer          not null, primary key
#  candidate_id :integer
#  name         :string
#  gender       :string
#  age          :string
#  relation     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CandidateFamilyMember < ActiveRecord::Base
  belongs_to :candidate
end
