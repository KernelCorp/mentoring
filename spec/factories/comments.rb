FactoryGirl.define do
  factory :comment do
    text "MyText"
    user 1
    commentable_id 1
    commentable_type 'Book'
  end

end
