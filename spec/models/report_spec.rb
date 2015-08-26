require 'rails_helper'

RSpec.describe Report, :type => :model do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, curator_id: curator.id, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id }
  let! (:meeting) { create :meeting, child_id: child.id, mentor_id: child.mentor.id }

  let :report do
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

  describe '#create' do
    context 'when new report is created' do
      subject do
        report
      end

      it { expect{subject}.to change{meeting.reload.state}.from('new').to('report_sent') }
    end
  end

  describe '#reject' do
    context 'when new report is rejected' do
      before do
        report
      end

      subject do
        report.reject
      end

      it { expect{subject}.to change{meeting.reload.state}.from('report_sent').to('report_rejected') }
    end
  end

  describe '#resend' do
    context 'when rejected report is resent' do
      before do
        report.reject
      end

      subject do
        report.resend
      end

      it { expect{subject}.to change{meeting.reload.state}.from('report_rejected').to('report_sent') }
    end
  end

  describe '#approve' do
    context 'when new report is approved' do
      before do
        report
      end

      subject do
        report.approve
      end

      it { expect{subject}.to change{meeting.reload.state}.from('report_sent').to('report_approved') }
    end
  end
end
