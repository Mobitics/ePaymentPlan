require 'spec_helper'

describe "merchant/plans/index.html.erb" do
  before(:each) do
    assign(:merchant_plans, [
      stub_model(Plan),
      stub_model(Plan)
    ])
  end

  it "renders a list of merchant/plans" do
    render
  end
end
