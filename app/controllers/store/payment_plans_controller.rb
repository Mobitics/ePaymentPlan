class Store::PaymentPlansController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
    if request.xhr?
    	time_range=nil
    	if(params[:init_date]!=nil)
    		init_date=params[:init_date].to_s.split("/")
    		end_date=params[:end_date].to_s.split("/")
    		init_date=Time.mktime(init_date[2],init_date[0],init_date[1])
    		end_date=Time.mktime(end_date[2],end_date[0],end_date[1])
    	elsif(params[:period]!=nil)
    	  if params[:period]=="this-week"
    	  		init_date=Time.now.beginning_of_week()
    	  		end_date=Time.now.end_of_week()
    	  elsif params[:period]=="last-week"
    	  		init_date=(Time.now.beginning_of_week()- 1.day).beginning_of_week()
    	  		end_date=Time.now.beginning_of_week()- 1.day
    	  elsif params[:period]=="this-month"
    	  		init_date=Time.now.beginning_of_month()
    	  		end_date=Time.now.end_of_month()
    	  elsif params[:period]=="last-month"
    	  	init_date=(Time.now.beginning_of_month()- 1.day).beginning_of_month()
    	  	end_date=Time.now.beginning_of_month()- 1.day
    	  else
    	  	init_date=Time.now.beginning_of_year()
    	  	end_date=Time.now.end_of_year()			
    	  end	
    	else	
    		@payment_plans = @store.payment_plans
    	end	
    	time_range=init_date .. end_date
    	@payment_plans = @store.payment_plans.where(:created_at => time_range)	
       	render :layout => false, :partial => 'table'
       	return  
    else
    	@payment_plans = @store.payment_plans
    	respond_to do |format|
    		format.html # index.html.erb
      		format.json { render json: @payment_plans }
    	end
    end
  end

  def show
    @payment_plan = @store.payment_plans.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan }
    end
  end
end
