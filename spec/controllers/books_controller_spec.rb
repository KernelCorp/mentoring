require 'rails_helper'

RSpec.describe BooksController, :type => :controller do

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:book) { create :book, owner_id: curator.id }

  let :valid_attributes do
    {
        name: 'Lord of Flies',
        priority: Book.priorities.keys.first,
        owner_id: curator.id
    }
  end

  let :invalid_attributes do
    {
        owner_id: curator.id,
        priority: Book.priorities.keys.last
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
        get :show, id: book.to_param
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
      subject { post :create, book: valid_attributes }
      it { expect {subject}.to change(Book, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(books_path)
      end
    end

    context 'with invalid params' do
      before do
        post :create, book: invalid_attributes
      end

      it { expect(assigns(:book)).to be_a_new(Book) }
      it { expect(response).to render_template('new') }
    end
  end

  describe '#destroy' do
    context 'when logged in' do
      subject { delete :destroy, id: book.to_param }

      it { expect{subject}.to change(Book, :count).by(-1) }

      it do
        subject
        expect(response).to redirect_to(books_url)
      end
    end
  end

end
