class Store::AuthorizeNetsController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
  end

  def new
    @authorize_net = AuthorizeNet.new
  end

  def create
    @authorize_net = @store.build_authorize_net(params[:authorize_net])

    respond_to do |format|
      if @authorize_net.save
        format.html { redirect_to store_authorize_nets_path, notice: 'Authorize.Net configuration was saved.' }
        format.json { render json: @authorize_net, status: :created, location: store_authorize_net(@plan) }
      else
        format.html { render action: "new" }
        format.json { render json: @authorize_net.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    redirect_to new_store_authorize_net_path and return if @store.authorize_net.blank?
    @authorize_net = @store.authorize_net
  end

  def update
    @authorize_net = @store.authorize_net

    respond_to do |format|
      if @authorize_net.update_attributes(params[:authorize_net])
        format.html { redirect_to store_authorize_nets_path, notice: 'Authorize.Net configuration was saved.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @authorize_net.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @authorize_net = @store.authorize_net
    @authorize_net.destroy

    respond_to do |format|
      format.html { redirect_to store_authorize_nets_path }
      format.json { head :ok }
    end
  end
end
