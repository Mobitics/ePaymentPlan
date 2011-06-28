class Store::SettingsController < ApplicationController
  before_filter :authorized_store

  def index
  end
end
