class Store::SettingsController < ApplicationController
  before_filter :authorized_store
  layout "store"	
  def index
  	redirect_to :controller => "authorize_nets"
  end
end
