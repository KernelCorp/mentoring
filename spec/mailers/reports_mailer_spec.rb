require 'rails_helper'

RSpec.describe ReportsMailer, :type => :mailer do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, curator_id: curator.id, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id }
  let! (:meeting) { create :meeting, child_id: child.id, mentor_id: child.mentor.id }

  let! :report do
    create :report,
           meeting_id: meeting.id,
           duration: 2,
           aim: 'qq',
           short_description: 'short_description',
           feelings: 'feelings',
           questions: 'questions',
           next_aim: 'next_aim',
           result: 'ww',
           other_comments: 'other_comments'
  end

  let(:mail) { ReportsMailer.new_report report }

  describe '#new_report' do
    context 'when new report created' do
      it { expect(mail.to).to eql([curator.email]) }
    end
  end
end
