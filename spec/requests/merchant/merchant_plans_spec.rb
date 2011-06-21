require 'spec_helper'

describe "Merchant::Plans" do
  describe "GET /merchant/plans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get merchant_plans_path
      response.status.should be(200)
    end
  end
end
