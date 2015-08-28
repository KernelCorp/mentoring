require "rails_helper"

RSpec.describe PhotosController, :type => :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/photos/1").to route_to("photos#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/photos").to route_to("photos#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/photos/1").to route_to("photos#destroy", :id => "1")
    end

  end
end
