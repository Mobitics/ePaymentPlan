require "spec_helper"

describe Store::PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/store/plans").should route_to("store/plans#index")
    end

    it "routes to #new" do
      get("/store/plans/new").should route_to("store/plans#new")
    end

    it "routes to #show" do
      get("/store/plans/1").should route_to("store/plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/store/plans/1/edit").should route_to("store/plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/store/plans").should route_to("store/plans#create")
    end

    it "routes to #update" do
      put("/store/plans/1").should route_to("store/plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/store/plans/1").should route_to("store/plans#destroy", :id => "1")
    end

  end
end
