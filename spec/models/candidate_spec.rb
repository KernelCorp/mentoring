require 'rails_helper'

RSpec.describe Candidate, :type => :model do
  let(:candidate) { create :candidate, email: 'test_candidate_email@example.com' }
  let(:user) { create :user, email: "jojo@yahoo.com"}

  describe '#approve' do
    context 'when new candidate is approved' do
      subject do
        candidate.approve!
      end

      it { expect{subject}.to change{candidate.reload.state}.from('new').to('approved') }
      it { expect{subject}.to change(User, :count).by(1) }
    end
  end

  describe "Welcome Email" do
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    include Rails.application.routes.url_helpers

    it "should be set to be delivered to the email passed in" do
      @email = RegistrationMailer.welcome(user, "test_password")
      @email.should deliver_to("jojo@yahoo.com")
    end
  end

end
