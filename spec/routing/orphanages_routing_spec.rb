require "rails_helper"

RSpec.describe OrphanagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/orphanages").to route_to("orphanages#index")
    end

    it "routes to #new" do
      expect(:get => "/orphanages/new").to route_to("orphanages#new")
    end

    it "routes to #show" do
      expect(:get => "/orphanages/1").to route_to("orphanages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/orphanages/1/edit").to route_to("orphanages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/orphanages").to route_to("orphanages#create")
    end

    it "routes to #update" do
      expect(:put => "/orphanages/1").to route_to("orphanages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/orphanages/1").to route_to("orphanages#destroy", :id => "1")
    end

  end
end
