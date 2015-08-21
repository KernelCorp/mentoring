FactoryGirl.define do
  factory :report do
    duration 2
    aim 'MyText'
    result 'Mytext'
    state 'new'
    meeting_id 1
  end

end
