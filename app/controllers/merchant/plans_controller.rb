class Merchant::PlansController < ApplicationController
  before_filter :user_merchant?
  # GET /merchant/plans
  # GET /merchant/plans.json
  def index
    @merchant_plans = @user.plans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @merchant_plans }
    end
  end

  # GET /merchant/plans/1
  # GET /merchant/plans/1.json
  def show
    @merchant_plan = @user.plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @merchant_plan }
    end
  end

  # GET /merchant/plans/new
  # GET /merchant/plans/new.json
  def new
    @merchant_plan = Plan.new
    @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
    @products = [] #it need to be changed when products be done

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @merchant_plan }
    end
  end

  # GET /merchant/plans/1/edit
  def edit
    @merchant_plan = @user.plans.find(params[:id])
    @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
    @products = [] #it need be changed when products be done
  end

  # POST /merchant/plans
  # POST /merchant/plans.json
  def create
    @merchant_plan = @user.plans.new(params[:plan])

    respond_to do |format|
      if @merchant_plan.save
        format.html { redirect_to merchant_plan_path(@merchant_plan), notice: 'Plan was successfully created.' }
        format.json { render json: @merchant_plan, status: :created, location: merchant_plan(@merchant_plan) }
      else
        @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
        @products = [] #it need be changed when products be done
        format.html { render action: "new" }
        format.json { render json: @merchant_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /merchant/plans/1
  # PUT /merchant/plans/1.json
  def update
    @merchant_plan = @user.plans.find(params[:id])

    respond_to do |format|
      if @merchant_plan.update_attributes(params[:plan])
        format.html { redirect_to merchant_plan_path(@merchant_plan), notice: 'Plan was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @merchant_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchant/plans/1
  # DELETE /merchant/plans/1.json
  def destroy
    @merchant_plan = @user.plans.find(params[:id])
    @merchant_plan.destroy

    respond_to do |format|
      format.html { redirect_to merchant_plans_url }
      format.json { head :ok }
    end
  end
end
