# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :datetime
#  state      :string
#  child_id   :integer
#  mentor_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meeting < ActiveRecord::Base
  include AASM

  belongs_to :child
  belongs_to :mentor, foreign_key: :mentor_id, class_name: 'User'
  has_one :report

  validates :child, presence: true
  validates :mentor_id, presence: true
  validates :date, presence: true

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected
    state :report_sent
    state :report_rejected
    state :report_approved

    event :reject do
      transitions from: :new, to: :rejected
    end

    event :send_report do
      transitions from: [:new, :report_rejected], to: :report_sent
    end

    event :reopen do
      transitions from: :rejected, to: :new
    end

    event :approve_report do
      transitions from: :report_sent, to: :report_approved
    end

    event :reject_report do
      transitions from: :report_sent, to: :report_rejected
    end
  end

end
