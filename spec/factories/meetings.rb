# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :datetime
#  state      :string
#  child_id   :integer
#  mentor_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :meeting do
    date DateTime.tomorrow
    state 'new'
    child_id 1
    mentor_id 2
  end

end
