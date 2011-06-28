require 'spec_helper'

describe "merchant/plans/edit.html.erb" do
  before(:each) do
    @merchant_plan = assign(:merchant_plan, stub_model(Plan))
  end

  it "renders the edit merchant_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => merchant_plans_path(@merchant_plan), :method => "post" do
    end
  end
end
