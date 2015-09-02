require 'rails_helper'

RSpec.describe PublicActivity::ActivitiesController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:curator) { create :user, :curator, orphanage_id: orphanage.id }

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
end
