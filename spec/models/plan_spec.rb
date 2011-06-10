require 'spec_helper'

describe Plan do

  describe "being created" do
    before(:each) do
      @plan_by_price_valid_attributes = {
        :name => "Plan Name",
        :payments_count => 10,
        :includes_shipping => true,
        :includes_tax => false,
        :interest => 10,
        :late_fee => 15,
        :plan_type => 'by_price',
        :min_price => 100,
        :max_price => 500
      }
      @plan_by_price_invalid_attributes = {
        :name => "",
        :payments_count => 10,
        :includes_shipping => true,
        :includes_tax => false,
        :interest => 10,
        :late_fee => 15,
        :plan_type => 'by_price',
        :min_price => 100,
        :max_price => 500
      }
    end

    it "should create given valid attributes" do
      create_plan(@plan_by_price_valid_attributes).should be_valid
    end

    it "should not create without a name" do
      create_plan(@plan_by_price_invalid_attributes).should_not be_valid
    end
  
  end

  private

  def create_plan(attributes)
    @plan = Plan.new(attributes) 
    @plan.save
    @plan
  end
end
