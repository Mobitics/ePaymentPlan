class Order < ActiveRecord::Base
  attr_readonly :amount, :shipping, :tax, :notify_url, :return_url, :cancel_return_url
end
