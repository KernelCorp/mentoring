require 'rails_helper'

RSpec.describe MeetingsController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }
  let! (:user) { create :user, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id  }
  let! (:meeting) { create :meeting, mentor_id: mentor.id, child_id: child.id  }
  let! (:rejected_meeting) { create :meeting, state: 'rejected', mentor_id: mentor.id, child_id: child.id  }

  let :valid_attributes do
    {
        date: 4.days.since,
        child_id: child.id,
        mentor_id: child.mentor.id
    }
  end

  let :invalid_attributes do
    {
        date: 4.days.since,
        mentor_id: mentor.id
    }
  end

  before(:each) {sign_in mentor}

  describe '#index' do
    context 'when logged in' do
      before do
        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('index') }
    end
  end

  describe '#show' do
    context 'when logged in' do
      before do
        get :show, id: meeting.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('show') }
    end
  end

  describe '#new' do
    context 'when logged in' do
      before do
        get :new
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#create' do
    context 'with valid params' do
      subject { post :create, meeting: valid_attributes }
      it { expect {subject}.to change(Meeting, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(Meeting.last)
      end
    end

    context 'with invalid params' do
      before do
        post :create, meeting: invalid_attributes
      end

      it { expect(assigns(:meeting)).to be_a_new(Meeting) }
      it { expect(response).to render_template('new') }
    end
  end


  describe '#destroy' do
    context 'destroys the requested meeting' do
      subject { delete :destroy, {:id => meeting.reload.to_param} }
      it { expect {subject}.to change(Meeting, :count).by(-1) }

      it do
        subject
        expect(response).to redirect_to(meetings_url)
      end
    end
  end

  describe '#reject' do
    context 'when called for new meeting' do
      subject { get :reject, {id: meeting.to_param} }
      it { expect{subject}.to change{meeting.reload.state}.from('new').to('rejected') }
    end

    context 'when called for rejected meeting' do
      subject { get :reject, {id: rejected_meeting.to_param} }
      it { expect{subject}.to_not change{rejected_meeting.reload.state} }
    end
  end

  describe '#reopen' do
    context 'when called for new meeting' do
      subject { get :reopen, {id: meeting.to_param} }
      it { expect{subject}.to_not change{meeting.reload.state} }
    end

    context 'when called for rejected meeting' do
      subject { get :reopen, {id: rejected_meeting.to_param} }
      it { expect{subject}.to change{rejected_meeting.reload.state}.from('rejected').to('new') }
    end
  end

end
