class PlansController < ApplicationController
  before_filter :find_plan, :except => [:index, :new, :create]
  
  def index
    @plans = Plan.all
  end
  
  def show
  end

  def new
    @plan = Plan.new
    @plan_types = [["By price range", "by_price"], ["By Product", "by_product"]]
    @products = [] #it need be changed when products be done
  end

  def create
    @plan = Plan.new params[:plan]
    if @plan.save
      redirect_to plans_path
    else
      @plan_types = [["By price range", "by_price"], ["By Product", "by_product"]]
      @products = [] #it need be changed when products be done
      render :new
    end

  end

  def edit
    @plan_types = [["By price range", "by_price"], ["By Product", "by_product"]]
    @products = [] #it need be changed when products be done
  end

  def update
    if @plan.update_attributes params[:plan]
      redirect_to plan_path @plan
    else
      @plan_types = [["By price range", "by_price"], ["By Product", "by_product"]]
      @products = [] #it need be changed when products be done
      render :new
    end
  end

  def destroy
    @plan.destroy    
    redirect_to plans_path  
  end

  private
  
  def find_plan
    @plan = Plan.find params[:id]
  end
end
