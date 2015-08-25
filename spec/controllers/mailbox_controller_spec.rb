require 'rails_helper'

RSpec.describe MailboxController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }

  describe '#inbox' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :inbox
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('inbox') }
    end

    context 'when logged out' do
      before do
        get :inbox
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to_not render_template('inbox') }
    end
  end

  describe '#sent' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :sent
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('sent') }
    end

    context 'when logged out' do
      before do
        get :sent
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to_not render_template('sent') }
    end
  end

  describe '#trash' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :trash
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('trash') }
    end

    context 'when logged out' do
      before do
        get :trash
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to_not render_template('trash') }
    end
  end
end
