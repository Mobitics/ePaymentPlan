require 'spec_helper'

describe TransactionsController do
  
  before :all do
    @pp = Factory(:payment_profile)
    @user = @pp.user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index', :user_id => @user.id, :payment_profile_id => @pp.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :user_id => @user.id, :payment_profile_id => @pp.id
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create', :user_id => @user.id, :payment_profile_id => @pp.id
      response.should be_success
    end
  end
  
  after :all do
    @user.destroy
  end

end
