require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, curator_id: curator.id, orphanage_id: orphanage.id }
  let! (:child) { create :child, orphanage_id: orphanage.id, mentor_id: mentor.id }
  let! (:meeting) { create :meeting, child_id: child.id, mentor_id: child.mentor.id }

  let! :report do
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

  let! :rejected_report do
    create :report,
           meeting_id: meeting.id,
           state: 'rejected',
           duration: 2,
           aim: 'qq',
           short_description: 'short_description',
           feelings: 'feelings',
           questions: 'questions',
           next_aim: 'next_aim',
           result: 'ww',
           other_comments: 'other_comments'
  end

  let :valid_attributes do
    {
        duration: 3,
        meeting_id: meeting.id,
        aim: 'qwe asd',
        short_description: 'short_description',
        feelings: 'feelings',
        questions: 'questions',
        next_aim: 'next_aim',
        result: 'ww',
        other_comments: 'other_comments'
    }
  end

  let :invalid_attributes do
    {
        duration: 3,
        meeting_id: meeting.id,
        result: 'asd zxc'
    }
  end

  describe '#index' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :index
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('index') }
    end
  end

  describe '#show' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :show, id: report.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('show') }
    end
  end

  describe '#new' do
    context 'when logged in' do
      before do
        sign_in mentor
        get :new, meeting_id: meeting.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        sign_in mentor
      end

      subject { post :create, report: valid_attributes }
      it { expect {subject}.to change(Report, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(Meeting)
      end
    end

    context 'with invalid params' do
      before do
        sign_in mentor
        post :create, report: invalid_attributes
      end

      it { expect(assigns(:report)).to be_a_new(Report) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#reject' do
    before do
      sign_in curator
    end

    context 'when called for new report' do
      subject { get :reject, {id: report.to_param} }
      it { expect{subject}.to change{report.reload.state}.from('new').to('rejected') }
    end

    context 'when called for rejected report' do
      subject { get :reject, {id: rejected_report.to_param} }
      it { expect{subject}.to_not change{rejected_report.reload.state} }
    end
  end

  describe '#approve' do
    before do
      sign_in curator
    end

    context 'when called for new report' do
      subject { get :approve, {id: report.to_param} }
      it { expect{subject}.to change{report.reload.state}.from('new').to('approved') }
    end

    context 'when called for rejected report' do
      subject { get :approve, {id: rejected_report.to_param} }
      it { expect{subject}.to_not change{rejected_report.reload.state} }
    end
  end

end
