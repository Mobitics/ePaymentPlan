class Store::PlansController < ApplicationController
  	before_filter :authorized_store
	layout "store"
  # GET /store/plans
  # GET /store/plans.json
  def index
    @plans = @store.plans

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /store/plans/1
  # GET /store/plans/1.json
  def show
    @plan = @store.plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /store/plans/new
  # GET /store/plans/new.json
  def new
    @plan = Plan.new
    @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
    @products = [] #it need to be changed when products be done
    @frequences = [["Monthly","monthly"],["Weekly","weekly"],["Daily","daily"],["Hourly","hourly"]]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /store/plans/1/edit
  def edit
    @plan = @store.plans.find(params[:id])
    flash[:error] = "Cannot edit that plan." and redirect_to store_plans_path if @plan.is_readonly
    @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
    @products = [] #it need be changed when products be done
    @frequences = [["Monthly","monthly"],["Weekly","weekly"],["Daily","daily"],["Hourly","hourly"]]
  end

  # POST /store/plans
  # POST /store/plans.json
  def create
    @plan = @store.plans.new(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { redirect_to store_plan_path(@plan), notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: store_plan(@plan) }
      else
        @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
        @products = [] #it need be changed when products be done
        @frequences = [["Monthly","monthly"],["Weekly","weekly"],["Daily","daily"],["Hourly","hourly"]]
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /store/plans/1
  # PUT /store/plans/1.json
  def update
    @plan = @store.plans.find(params[:id])
    flash[:error] = "Cannot edit that plan." and redirect_to store_plans_path if @plan.is_readonly

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to store_plan_path(@plan), notice: 'Plan was successfully updated.' }
        format.json { head :ok }
      else
        @plan_types = Plan::PLAN_TYPES.to_a.map(&:reverse)
        @products = [] #it need be changed when products be done
        @frequences = [["Monthly","monthly"],["Weekly","weekly"],["Daily","daily"],["Hourly","hourly"]]
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store/plans/1
  # DELETE /store/plans/1.json
  def destroy
    @plan = @store.plans.find(params[:id])
    flash[:error] = "Cannot edit that plan." and redirect_to store_plans_path if @plan.is_readonly
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to store_plans_url }
      format.json { head :ok }
    end
  end
end
