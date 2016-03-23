# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string
#  last_name              :string
#  middle_name            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  curator_id             :integer
#  forem_admin            :boolean          default(FALSE)
#  forem_state            :string           default("pending_review")
#  forem_auto_subscribe   :boolean          default(FALSE)
#  orphanage_id           :integer
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'

    sequence(:first_name) {|n| "first_name_#{n}"}
    last_name 'any_last_name'
    middle_name 'any_middle_name'

    # orphanage_id 1 # мешает тестам

    trait :mentor do
      email 'mentor@example.com'
      curator_id 1
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
