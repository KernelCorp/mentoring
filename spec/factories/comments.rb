# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    text "MyText"
    user 1
    commentable_id 1
    commentable_type 'Book'
  end

end
