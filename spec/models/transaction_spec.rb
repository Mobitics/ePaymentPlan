require 'spec_helper'

describe Transaction do
  
  before :all do
    @user = Factory(:user_with_payment_profile)
    @payment_profile = @user.payment_profiles.first
  end
  
  it "should create a Transaction with valid data" do
    @transaction = @payment_profile.transactions.build :amount => 280
    @transaction.save.should == true
    @transaction.confirmation_id.should_not be_nil
  end
  
  before :all do
    @user.destroy
  end

end
