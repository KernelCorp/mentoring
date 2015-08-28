require 'rails_helper'

RSpec.describe PhotosController, :type => :controller do

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:album) { create :album, user: curator }
  let! (:photo) { create :photo, album: album, user: album.user }

  let :valid_attributes do
    {
        description: 'desc',
        image: Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/main_page/social20.png", 'image/png'),
        album_id: album.id,
        user_id: album.user.id
    }
  end

  let :invalid_attributes do
    {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/public/robots.txt", 'text/txt'),
        album_id: album.id,
        user_id: album.user.id
    }
  end

  before(:each) {sign_in curator}

  describe '#show' do
    context 'when logged in' do
      before do
        get :show, id: photo.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('show') }
    end
  end

  describe '#create' do
    context 'with valid params' do
      subject { post :create, photo: valid_attributes }
      it { expect {subject}.to change(Photo, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(album_path(album))
      end
    end

    context 'with invalid params' do
      before do
        post :create, photo: invalid_attributes
      end

      it { expect(assigns(:photo)).to be_a_new(Photo) }
      it { expect(response).to redirect_to(album_path(album)) }
    end
  end

  describe '#destroy' do
    context 'when logged in' do
      subject { delete :destroy, id: photo.to_param }

      it { expect{subject}.to change(Photo, :count).by(-1) }

      it do
        subject
        expect(response).to redirect_to(album_url(album))
      end
    end
  end

end
