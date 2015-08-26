require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }
  let! (:book) { create :book, owner_id: curator.id }

  let :valid_attributes do
    {
        text: 'Nice!',
        user_id: curator.id,
        commentable_id: book.id,
        commentable_type: 'Book'
    }
  end

  let :invalid_attributes do
    {
        user_id: curator.id,
        commentable_id: book.id,
        commentable_type: 'Book'
    }
  end

  before(:each) {sign_in curator}

  describe '#create' do
    context 'with valid params' do
      subject { post :create, comment: valid_attributes }
      it { expect {subject}.to change(Comment, :count).by(1) }

      it do
        subject
        expect(response).to redirect_to(book)
      end
    end

    context 'with invalid params' do
      before do
        post :create, comment: invalid_attributes
      end

      it { expect(assigns(:comment)).to be_a_new(Comment) }
      it { expect(response).to redirect_to(book) }
    end
  end

end
