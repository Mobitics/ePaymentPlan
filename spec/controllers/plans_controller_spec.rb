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
    @plan = Factory(:plan)
  end
  
  context "on METHOD to #action" do
    it "should response success on GET to #index" do
      get :index
      response.should render_template('index')
    end
    
    it "should response success on GET to #show" do
      get :show, :id => @plan.id
      response.should render_template('show')
    end
    
    it "should response success on GET to #edit" do
      get :edit, :id => @plan.id
      response.should render_template('edit')
    end
    
    it "should response success on GET to #create" do
      @valid_attributes = Factory.attributes_for(:plan)
      post :create, @valid_attributes
      assign(:plans).should_not be_empty
      response.should render_template('index')
    end
    
    it "should response success on GET to #create" do
      @valid_attributes = Factory.attributes_for(:plan)
      @valid_attributes[:name] = ""
      @invalid_attributes = @valid_attributes
      post :create, @invalid_attributes
      response.should render_template('new')
    end
  end

end
