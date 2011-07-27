class Store::StoresController < ApplicationController
  before_filter :authorized_store
  layout "store"
  def index
  end
end
