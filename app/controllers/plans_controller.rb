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
  end

  def update
  end

  def destroy
  end

  private
  
  def find_plan
    @plan = Plan.find params[:id]
  end
end
