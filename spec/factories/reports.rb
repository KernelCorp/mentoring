# == Schema Information
#
# Table name: reports
#
#  id                :integer          not null, primary key
#  aim               :text
#  state             :string
#  meeting_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  duration          :integer
#  short_description :text
#  result            :text
#  feelings          :text
#  questions         :text
#  next_aim          :text
#  other_comments    :text
#

FactoryGirl.define do
  factory :report do
    duration 2
    aim 'aim'
    short_description 'short_description'
    feelings 'feelings'
    questions 'questions'
    next_aim 'next_aim'
    result 'result'
    other_comments 'other_comments'
    meeting_id 1
  end

end
