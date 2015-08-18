FactoryGirl.define do
  factory :child do
    first_name "Putin"
    last_name "VVP"
    middle_name "SVCH"
    birthdate 14.years.ago
    orphanage_id 1
    mentor_id 1
  end

end
