class Report < ActiveRecord::Base
  include AASM

  belongs_to :meeting
  validates :meeting, presence: true

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :rejected
    state :verified

    event :reject do
      transitions from: :new, to: :rejected
    end

    event :resend do
      transitions from: :rejected, to: :new
    end

    event :verify do
      transitions from: :new, to: :verified
    end
  end
end
