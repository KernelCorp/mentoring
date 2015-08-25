require 'rails_helper'

RSpec.describe ConversationsController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id, curator_id: curator.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id  }
  let! (:conversation) { curator.send_message(mentor, 'body', 'subj').conversation }

  let :create_attributes do
    {
        recipients: [curator.id],
        body: 'body',
        subject: 'subj'
    }
  end

  let :valid_reply_attributes do
    {
        body: 'body'
    }
  end

  let :invalid_reply_attributes do
    {
        id: conversation.id
    }
  end

  describe '#show' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :show, id: conversation.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('show') }
    end

    context 'when logged out' do
      before do
        get :show, id: conversation.to_param
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to_not render_template('show') }
    end
  end

  describe '#new' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :new
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#create' do
    before do
      sign_in mentor
    end

    context 'with valid params' do
      subject { post :create, conversation: create_attributes }
      it { expect {subject}.to change(mentor.mailbox.sentbox, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(conversation_path(mentor.mailbox.sentbox.last))
      end
    end
  end

  describe '#reply' do
    before do
      sign_in mentor
    end

    context 'with valid params' do
      subject { post :reply, {id: conversation.to_param, message: valid_reply_attributes}  }
      it { expect {subject}.to change(conversation.messages, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(conversation_path(conversation))
      end
    end

    context 'with invalid params' do
      subject { post :reply, {id: conversation.to_param, message: invalid_reply_attributes} }
      it { expect{subject}.to_not change(conversation.messages, :count) }
    end
  end

  describe '#trash' do
    context 'when logged in' do
      before do
        sign_in mentor
      end

      subject { post :trash, {id: conversation.to_param} }
      it { expect{subject}.to change{conversation.is_trashed?(mentor)}.from(false).to(true) }
    end
  end

  describe '#untrash' do
    context 'when logged in' do
      before do
        sign_in mentor
        conversation.move_to_trash(mentor)
      end

      subject { post :untrash, {id: conversation.to_param} }
      it { expect{subject}.to change{conversation.is_trashed?(mentor)}.from(true).to(false) }
    end
  end

end
