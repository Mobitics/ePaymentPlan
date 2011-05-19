class SiteController < ApplicationController
  def home
  end
  
  def purchase
    render :text => params.inspect
  end 
  # Secret answer: Simon
  # 3yRSgPY95j
  # 3TKP3P9x8hD38wpW
end
