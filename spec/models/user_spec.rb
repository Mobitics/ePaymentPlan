require 'spec_helper'

describe User do
  
  before :all do
    @valid_params = Factory.attributes_for(:user)
  end
  
  it "should create successfully a user" do
    @user = User.new @valid_params
    @user.save.should == true
  end
  
  after :all do
    @user.destroy
  end
end
