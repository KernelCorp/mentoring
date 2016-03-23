require 'rails_helper'

RSpec.describe CandidatesMailer, :type => :mailer do
  let! (:admin) { create :user, :admin }
  let! (:candidate) { create :candidate }
  let(:mail) { CandidatesMailer.bid_received candidate }
  let(:mail2) { CandidatesMailer.bid_sent candidate }

  describe '#bid_received' do
    context 'when new candidate created' do
      it { expect(mail.to).to eql([admin.email]) }
      it { expect(mail2.to).to eql([candidate.email]) }
    end
  end
end
