FactoryGirl.define do
  factory :candidate_education do
    education "Средне-высшее"
    start_date  6.years.ago
    end_date 1.years.ago
    specialty "Специальность"
  end

end