FactoryGirl.define do
  factory :meeting do
    date "2015-08-19"
    state 'new'
    child_id 1
    mentor_id 2
  end

end
