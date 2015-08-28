require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  let! (:orphanage) { create :orphanage }
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }

  before (:each) { sign_in curator}

  describe '#show' do
    context 'when logged in' do
      before do
        get :show, id: curator.to_param
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('show') }
    end
  end

end
