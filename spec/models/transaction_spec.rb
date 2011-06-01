require 'spec_helper'

describe Transaction do
  
  before :all do
    @payment_profile = Factory(:payment_profile)
    @user = @payment_profile.user
  end
  
  it "should create a Transaction with valid data" do
    @transaction = @payment_profile.transactions.build :amount => 280
    @transaction.save.should == true
    @transaction.confirmation_id.should_not be_nil
  end
  
  after :all do
    @user.destroy
  end
end
