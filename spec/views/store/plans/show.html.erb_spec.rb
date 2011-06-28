require 'spec_helper'

describe "merchant/plans/show.html.erb" do
  before(:each) do
    @merchant_plan = assign(:merchant_plan, stub_model(Plan))
  end

  it "renders attributes in <p>" do
    render
  end
end
