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

class Report < ActiveRecord::Base
  belongs_to :meeting
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  include AASM
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { model.meeting.mentor }

  validates :meeting,         presence: true
  validates :duration,        presence: true
  validates :aim,             presence: true
  validates :short_description, presence: true
  validates :result,          presence: true
  validates :feelings,        presence: true
  validates :questions,       presence: true
  validates :next_aim,        presence: true
  validates :other_comments,  presence: true

  after_create do
    meeting.send_report!
  end

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected
    state :approved

    event :reject do
      after do
        meeting.reject_report
        meeting.save

        create_activity :reject, owner: meeting.mentor.curator
      end

      transitions from: :new, to: :rejected
    end

    event :resend do
      after do
        meeting.send_report
        meeting.save

        create_activity :resend, owner: meeting.mentor
      end

      transitions from: :rejected, to: :new
    end

    event :approve do
      after do
        meeting.approve_report
        meeting.save

        create_activity :approve, owner: meeting.mentor.curator
      end

      transitions from: :new, to: :approved
    end
  end

end
