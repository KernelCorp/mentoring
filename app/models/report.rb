class Report < ActiveRecord::Base
  include AASM

  belongs_to :meeting
end
