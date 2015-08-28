require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:album) { create :album, user: curator }

  let :valid_attributes do
    {
        title: '1st album',
        description: 'desc',
        user_id: curator.id
    }
  end

  let :invalid_attributes do
    {
        title: nil,
        description: 'desc',
        user_id: curator.id
    }
  end

  before(:each) {sign_in curator}

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
        get :show, id: album.to_param
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

  describe '#edit' do
    context 'when logged in' do
      before do
        get :edit, id: album.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('edit') }
    end
  end

  describe '#create' do
    context 'with valid params' do
      subject { post :create, album: valid_attributes }
      it { expect {subject}.to change(Album, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(Album.last)
      end
    end

    context 'with invalid params' do
      before do
        post :create, album: invalid_attributes
      end

      it { expect(assigns(:album)).to be_a_new(Album) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#update' do
    context 'with valid params' do
      subject { put :update, {id: album.to_param, album: valid_attributes} }

      it { expect{subject}.to change{album.reload.title}.to(valid_attributes[:title]) }

      it do
        subject
        expect(response).to redirect_to(album)
      end
    end

    context 'with invalid params' do
      subject { put :update, {id: album.to_param, album: invalid_attributes} }

      it { expect{subject}.to_not change{album.reload.title} }

      it do
        subject
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    context 'when logged in' do
      subject { delete :destroy, id: album.to_param }

      it { expect{subject}.to change(Album, :count).by(-1) }

      it do
        subject
        expect(response).to redirect_to(albums_url)
      end
    end
  end

end
