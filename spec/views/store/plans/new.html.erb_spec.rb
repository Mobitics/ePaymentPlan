require 'spec_helper'

describe "merchant/plans/new.html.erb" do
  before(:each) do
    assign(:merchant_plan, stub_model(Plan).as_new_record)
  end

  it "renders new merchant_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => merchant_plans_path, :method => "post" do
    end
  end
end
