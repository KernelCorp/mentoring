FactoryGirl.define do
  factory :meeting do
    date DateTime.tomorrow
    state 'new'
    child_id 1
    mentor_id 2
  end

end
