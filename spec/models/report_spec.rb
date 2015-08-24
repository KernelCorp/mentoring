require 'rails_helper'

RSpec.describe Report, :type => :model do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, curator_id: curator.id, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id }
  let! (:meeting) { create :meeting, child_id: child.id, mentor_id: child.mentor.id }
  let (:report) { create :report, meeting_id: meeting.id, duration: 2, aim: 'qq', result: 'ww' }

  describe '#create' do
    context 'when new report is created' do
      subject do
        Report.create! meeting_id: meeting.id, duration: 2, aim: '231', result: 'wrq'
      end

      it { expect{subject}.to change{meeting.reload.state}.from('new').to('report_sent') }
    end
  end

  describe '#reject' do
    context 'when new report is rejected' do
      subject do
        report.reject
      end

      it { expect{subject}.to change{meeting.reload.state}.from('new').to('report_rejected') }
    end
  end

  describe '#reject' do
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
