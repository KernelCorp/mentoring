# == Schema Information
#
# Table name: candidate_educations
#
#  id           :integer          not null, primary key
#  candidate_id :integer
#  education    :string
#  start_date   :date
#  end_date     :date
#  specialty    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CandidateEducation < ActiveRecord::Base
  belongs_to :candidate
end
