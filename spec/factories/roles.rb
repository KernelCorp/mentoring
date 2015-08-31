# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :role do
    name 'mentor'

    trait :curator do
      name 'curator'
    end

    trait :admin do
      name 'admin'
    end
  end
end
