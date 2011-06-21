require "spec_helper"

describe Merchant::PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/merchant/plans").should route_to("merchant/plans#index")
    end

    it "routes to #new" do
      get("/merchant/plans/new").should route_to("merchant/plans#new")
    end

    it "routes to #show" do
      get("/merchant/plans/1").should route_to("merchant/plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/merchant/plans/1/edit").should route_to("merchant/plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/merchant/plans").should route_to("merchant/plans#create")
    end

    it "routes to #update" do
      put("/merchant/plans/1").should route_to("merchant/plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/merchant/plans/1").should route_to("merchant/plans#destroy", :id => "1")
    end

  end
end
