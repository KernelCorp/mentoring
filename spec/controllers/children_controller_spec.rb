require 'rails_helper'

RSpec.describe ChildrenController, :type => :controller do

  let! (:orphanage) { create :orphanage}
  let! (:admin) { create :user, :admin, orphanage_id: orphanage.id }
  let! (:mentor) { create :user, :mentor, orphanage_id: orphanage.id }

  let(:valid_attributes) do
    {
      first_name: 'Adolf',
      last_name: 'Hitler',
      middle_name: 'Shickle',
      orphanage_id: orphanage.id,
      mentor_id: mentor.id
    }
  end

  let(:invalid_attributes) do
    {
      first_name: 'Adolf',
      middle_name: 'Shickle',
      mentor_id: mentor.id
    }
  end

  before(:each) { sign_in admin }

  describe "GET index" do
    it "assigns all children as @children" do
      child = Child.create! valid_attributes
      get :index, {}
      expect(assigns(:children)).to eq([child])
    end
  end

  describe "GET show" do
    it "assigns the requested child as @child" do
      child = Child.create! valid_attributes
      get :show, {:id => child.to_param}
      expect(assigns(:child)).to eq(child)
    end
  end

  describe "GET new" do
    it "assigns a new child as @child" do
      get :new
      expect(assigns(:child)).to be_a_new(Child)
    end
  end

  describe "GET edit" do
    it "assigns the requested child as @child" do
      child = Child.create! valid_attributes
      get :edit, {:id => child.to_param}
      expect(assigns(:child)).to eq(child)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Child" do
        expect {
          post :create, {:child => valid_attributes}
        }.to change(Child, :count).by(1)
      end

      it "assigns a newly created child as @child" do
        post :create, {:child => valid_attributes}
        expect(assigns(:child)).to be_a(Child)
        expect(assigns(:child)).to be_persisted
      end

      it "redirects to the created child" do
        post :create, {:child => valid_attributes}
        expect(response).to redirect_to(Child.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved child as @child" do
        post :create, {:child => invalid_attributes}
        expect(assigns(:child)).to be_a_new(Child)
      end

      it "re-renders the 'new' template" do
        post :create, {:child => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) do
        {
            first_name: 'Kastro'
        }
      end

      it "updates the requested child" do
        child = Child.create! valid_attributes
        put :update, {:id => child.to_param, :child => new_attributes}
        child.reload
        expect(child.first_name).to eq('Kastro')
      end

      it "assigns the requested child as @child" do
        child = Child.create! valid_attributes
        put :update, {:id => child.to_param, :child => valid_attributes}
        expect(assigns(:child)).to eq(child)
      end

      it "redirects to the child" do
        child = Child.create! valid_attributes
        put :update, {:id => child.to_param, :child => valid_attributes}
        expect(response).to redirect_to(child)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested child" do
      child = Child.create! valid_attributes
      expect {
        delete :destroy, {:id => child.to_param}
      }.to change(Child, :count).by(-1)
    end

    it "redirects to the children list" do
      child = Child.create! valid_attributes
      delete :destroy, {:id => child.to_param}
      expect(response).to redirect_to(children_url)
    end
  end

end
