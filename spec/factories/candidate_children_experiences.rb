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

FactoryGirl.define do
  factory :candidate_children_experience do
    organization_name "Вектор"
    organization_contacts "Улица Пушкина, дом Колотушкина"
    position "Самый главный президент"
    functions "Какие-то функции"
    children_age "33"
  end

end
