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
