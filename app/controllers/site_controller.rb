class SiteController < ApplicationController
  include ActiveMerchant::Billing::Integrations::ActionViewHelper
  
  def home
  end

  def test
  end
end
