FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'

    first_name 'name'
    last_name 'name'
    middle_name 'name'

    trait :mentor do
      email 'mentor@example.com'
      after(:create) {|user| user.add_role(:mentor)}
    end

    trait :curator do
      email 'psych@example.com'
      after(:create) {|user| user.add_role(:curator)}
    end

    trait :admin do
      email 'admin@example.com'
      after(:create) {|user| user.add_role(:admin)}
    end
  end

end
