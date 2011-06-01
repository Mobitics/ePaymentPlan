require 'spec_helper'

describe PaymentProfile do
  
  before(:all) do
    @user = Factory(:user)
    
    @valid_credit_card = {
      :number => 4007000000027,
      :month => 10,
      :year => 2010,
      :first_name => 'Bob',
      :last_name => 'Smith',
      :verification_value => '111',
      :type => 'visa'
    }
    @address = { 
      :name => 'Bob Smith', 
      :address1 => '123 Down the Road',
      :city => 'San Francisco', 
      :state => 'CA',
      :country => 'US',
      :zip => '23456',
      :phone => '(555)555-5555' 
    } 
    
  end
  
  it "should create a payment profile" do
    @payment_profile = @user.payment_profiles.build :address => @address, :credit_card => @valid_credit_card
    @payment_profile.save.should == true
    @payment_profile.payment_cim_id.should_not be_nil
  end
  
  after(:all) do
    @user.destroy
  end
  
end
