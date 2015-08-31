# == Schema Information
#
# Table name: candidates
#
#  id                       :integer          not null, primary key
#  last_name                :string
#  first_name               :string
#  middle_name              :string
#  registration_address     :string
#  home_address             :string
#  phone_number             :string
#  email                    :string
#  birth_date               :date
#  nationality              :string
#  confession               :string
#  health_status            :string
#  serious_diseases         :string
#  work_start_date          :date
#  work_end_date            :date
#  organization_name        :string
#  work_contacts            :string
#  work_position            :string
#  work_functions           :text
#  work_schedule            :string
#  hobby                    :text
#  martial_status           :string
#  house_type               :string
#  number_of_rooms          :string
#  peoples_for_room         :string
#  peoples                  :text
#  pets                     :string
#  program_role             :string
#  program_reason           :text
#  person_character         :text
#  person_information       :text
#  help_reason              :text
#  child_age                :string
#  child_gender             :string
#  child_character          :text
#  visit_frequency          :string
#  invalid_child            :boolean
#  alcohol                  :string
#  tobacco                  :string
#  psychoactive             :string
#  drugs                    :string
#  child_crime              :string
#  disabled_parental_rights :string
#  reports                  :boolean
#  photo_rights             :boolean
#  info_about_program       :string
#  state                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

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
