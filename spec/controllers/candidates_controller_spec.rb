require 'rails_helper'

RSpec.describe CandidatesController, :type => :controller do
  describe "GET new" do
    it "assigns a new candidate as @candidate" do
      get :new
      expect(assigns(:candidate)).to be_a_new(Candidate)
    end
  end

  describe "POST create" do

    let(:valid_attributes) {{
        last_name: "Laden",
        first_name: "Osama",
        middle_name: "Bin",
        registration_address: "Pakistan, Al'Kaida Street",
        home_address: "Same as registration adress",
        phone_number: "+71112223344",
        email: "osama@alkaida.com",
        birth_date: 50.years.ago,
        nationality: "Pakistan",
        confession: "Islam"
    }}

    it "creates a new Candidate with valid params" do
      expect {
        post :create, {candidate: valid_attributes}
      }.to change(Candidate, :count).by(1)
    end
  end
end
