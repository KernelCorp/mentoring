require 'rails_helper'

RSpec.describe MailboxMailer, :type => :mailer do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id, curator_id: curator.id }
  let! (:conversation) { curator.send_message(mentor, 'body', 'subj').conversation }


  let(:mail) { MailboxMailer.new_message mentor, curator }

  describe '#new_message' do
    context 'when new message is received' do
      it { expect(mail.to).to eql([mentor.email]) }
    end
  end
end
