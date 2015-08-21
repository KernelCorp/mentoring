class Report < ActiveRecord::Base
  include AASM

  belongs_to :meeting

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
      transitions from: :new, to: :rejected do
        after do
          meeting.reject_report
          meeting.save
        end
      end
    end

    event :resend do
      transitions from: :rejected, to: :new do
        after do
          meeting.send_report
          meeting.save
        end
      end
    end

    event :approve do
      transitions from: :new, to: :approved do
        after do
          meeting.approve_report
          meeting.save
        end
      end
    end
  end

end
