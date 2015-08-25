require 'rails_helper'

RSpec.describe OrphanagesController, :type => :controller do

  let! (:admin) { create :user, :admin }

  let(:valid_attributes) do
    {
        name: 'palata №6',
        address: 'hbz'
    }
  end

  let(:invalid_attributes) do
    {
        address: 'hbz'
    }
  end

  before(:each) { sign_in admin }

  describe "GET index" do
    it "assigns all orphanages as @orphanages" do
      orphanage = Orphanage.create! valid_attributes
      get :index, {}
      expect(assigns(:orphanages)).to eq([orphanage])
    end
  end

  describe "GET show" do
    it "assigns the requested orphanage as @orphanage" do
      orphanage = Orphanage.create! valid_attributes
      get :show, {:id => orphanage.to_param}
      expect(assigns(:orphanage)).to eq(orphanage)
    end
  end

  describe "GET new" do
    it "assigns a new orphanage as @orphanage" do
      get :new, {}
      expect(assigns(:orphanage)).to be_a_new(Orphanage)
    end
  end

  describe "GET edit" do
    it "assigns the requested orphanage as @orphanage" do
      orphanage = Orphanage.create! valid_attributes
      get :edit, {:id => orphanage.to_param}
      expect(assigns(:orphanage)).to eq(orphanage)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Orphanage" do
        expect {
          post :create, {:orphanage => valid_attributes}
        }.to change(Orphanage, :count).by(1)
      end

      it "assigns a newly created orphanage as @orphanage" do
        post :create, {:orphanage => valid_attributes}
        expect(assigns(:orphanage)).to be_a(Orphanage)
        expect(assigns(:orphanage)).to be_persisted
      end

      it "redirects to the created orphanage" do
        post :create, {:orphanage => valid_attributes}
        expect(response).to redirect_to(Orphanage.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved orphanage as @orphanage" do
        post :create, {:orphanage => invalid_attributes}
        expect(assigns(:orphanage)).to be_a_new(Orphanage)
      end

      it "re-renders the 'new' template" do
        post :create, {:orphanage => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) do
        {
            name: 'office 407'
        }
      end

      it "updates the requested orphanage" do
        orphanage = Orphanage.create! valid_attributes
        put :update, {:id => orphanage.to_param, :orphanage => new_attributes}
        orphanage.reload
        expect(orphanage.name).to eq(new_attributes[:name])
      end

      it "assigns the requested orphanage as @orphanage" do
        orphanage = Orphanage.create! valid_attributes
        put :update, {:id => orphanage.to_param, :orphanage => valid_attributes}
        expect(assigns(:orphanage)).to eq(orphanage)
      end

      it "redirects to the orphanage" do
        orphanage = Orphanage.create! valid_attributes
        put :update, {:id => orphanage.to_param, :orphanage => valid_attributes}
        expect(response).to redirect_to(orphanage)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested orphanage" do
      orphanage = Orphanage.create! valid_attributes
      expect {
        delete :destroy, {:id => orphanage.to_param}
      }.to change(Orphanage, :count).by(-1)
    end

    it "redirects to the orphanages list" do
      orphanage = Orphanage.create! valid_attributes
      delete :destroy, {:id => orphanage.to_param}
      expect(response).to redirect_to(orphanages_url)
    end
  end

end
