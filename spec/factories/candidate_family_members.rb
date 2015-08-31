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

FactoryGirl.define do
  factory :candidate_family_member do
    name "Какое-то имя"
    gender "Какой-то пол"
    age "55"
    relation "Шурин"
  end

end
