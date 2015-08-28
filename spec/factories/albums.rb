FactoryGirl.define do
  factory :album do
    title "MyString"
    description "MyText"
    user User.first
  end

end
