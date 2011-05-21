require 'spec_helper'

describe PlansController do
  
  it { {:get => '/plans'}.should route_to(:controller => 'plans', :action => 'index') }
  it { {:get => '/plans/new'}.should route_to(:controller => 'plans', :action => 'new') }
  it { {:post => '/plans'}.should route_to(:controller => 'plans', :action => 'create') }
  it { {:get => '/plans/1'}.should route_to(:controller => 'plans', :action => 'show', :id => '1') } 
  it { {:get => '/plans/1/edit'}.should route_to(:controller => 'plans', :action => 'edit', :id => '1') } 
  it { {:put => '/plans/1'}.should route_to(:controller => 'plans', :action => 'update', :id => '1') }
  it { {:delete => '/plans/1'}.should route_to(:controller => 'plans', :action => 'destroy', :id => '1') }  
  
  before(:each) do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("darth:vader")
  end
  
  context "on METHOD to #action" do
    it "should response success on GET to #index" do
      @plan = Factory(:plan)
      get :index
      assigns[:plans].should_not be_empty
      response.should render_template('index')
    end
    
    it "should response success on GET to #show" do
      @plan = Factory(:plan)
      get :show, :id => @plan.id
      assigns[:plan].should_not be_nil
      response.should render_template('show')
    end
    
    it "should response success on GET to #edit" do
      @plan = Factory(:plan)
      get :edit, :id => @plan.id
      assigns[:plan].should_not be_nil      
      response.should render_template('edit')
    end
    
    it "should response success on PUT to #update" do
      @plan = Factory(:plan)
      attributes = @plan.attributes
      attributes[:name] = "Updated Name" 
      put :update, :id => @plan.id, :plan => attributes
      updated_plan = Plan.find @plan.id
      updated_plan.name.should be == "Updated Name"
      assigns[:plan].should_not be_nil      
      response.should render_template('edit')
    end
    
    it "should response success on POST to #create" do
      @valid_attributes = Factory.attributes_for(:plan)
      post :create, :plan => @valid_attributes
      assigns[:plan].should be_valid
      response.should redirect_to(plans_path)      
    end
    
    it "should response failed on POST to #create" do
      @valid_attributes = Factory.attributes_for(:plan)
      @valid_attributes[:name] = ""
      @invalid_attributes = @valid_attributes
      post :create, :plan => @invalid_attributes
      assigns[:plan].should_not be_valid
      response.should render_template('new')      
      response.should be_success
    end
    
    it "should response success on DELETE to #destroy" do
      @plan = Factory(:plan)
      delete :destroy, :id => @plan.id
      response.should redirect_to(plans_path)    
    end
    
  end

end
