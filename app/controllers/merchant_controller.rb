class MerchantController < ApplicationController
  before_filter :user_merchant?
  def index
  end

end
