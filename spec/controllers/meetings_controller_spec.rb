require 'rails_helper'

RSpec.describe MeetingsController, :type => :controller do

  let! (:mentor) { create :user, :mentor }
  let! (:user) { create :user }
  let! (:orphanage) { create :orphanage}
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
      it 'shows all available meetings' do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
      end
    end
  end

  describe '#show' do
    context 'when logged in' do
      it 'shows current meeting' do
        get :show, id: meeting.id
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
      end
    end
  end

  describe '#new' do
    context 'when logged in' do
      it 'shows meeting creation page' do
        get :new
        expect(response.status).to eq(200)
        expect(response).to render_template('new')
      end
    end
  end

=begin
  describe "GET edit" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :edit, {:id => meeting.to_param}, valid_session
      expect(assigns(:meeting)).to eq(meeting)
    end
  end
=end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new Meeting' do
        expect {
          post :create, meeting: valid_attributes
        }.to change(Meeting, :count).by(1)
      end

      it 'redirects to the created meeting' do
        post :create, meeting: valid_attributes
        expect(response).to redirect_to(Meeting.last)
      end
    end

    context 'with invalid params' do
      it 'tries to save meeting' do
        post :create, meeting: invalid_attributes
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end

      it 're-renders the "new" template' do
        post :create, meeting: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

=begin
  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested meeting' do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => new_attributes}, valid_session
        meeting.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested meeting as @meeting' do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        expect(assigns(:meeting)).to eq(meeting)
      end

      it 'redirects to the meeting' do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        expect(response).to redirect_to(meeting)
      end
    end

    describe 'with invalid params' do
      it 'assigns the meeting as @meeting' do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "re-renders the 'edit' template" do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested meeting' do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, {:id => meeting.to_param}, valid_session
      }.to change(Meeting, :count).by(-1)
    end

    it 'redirects to the meetings list' do
      meeting = Meeting.create! valid_attributes
      delete :destroy, {:id => meeting.to_param}, valid_session
      expect(response).to redirect_to(meetings_url)
    end
  end
=end

  describe '#reject' do
    context 'when called for new meeting' do
      subject { get :reject, {:id => meeting.to_param} }
      it { expect{subject}.to change{meeting.reload.state}.from('new').to('rejected') }
    end

    context 'when called for rejected meeting' do
      subject { get :reject, {:id => rejected_meeting.to_param} }
      it { expect{subject}.to_not change{rejected_meeting.reload.state} }
    end
  end

  describe '#reopen' do
    context 'when called for new meeting' do
      subject { get :reopen, {:id => meeting.to_param} }
      it { expect{subject}.to_not change{meeting.reload.state} }
    end

    context 'when called for rejected meeting' do
      subject { get :reopen, {:id => rejected_meeting.to_param} }
      it { expect{subject}.to change{rejected_meeting.reload.state}.from('rejected').to('new') }
    end
  end

end
