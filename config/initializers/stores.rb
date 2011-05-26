StoreConfig = YAML.load_file(File.open("#{Rails.root}/config/stores.yml"))
ShopifyAPI::Session.setup({:api_key => StoreConfig['Store1']['shopify']['api_key'],
                           :secret => StoreConfig['Store1']['shopify']['secret']
                         })
                         
module ActiveMerchant
  module Utils
    def get_payment_gateway
      gateway = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
        :login => StoreConfig['Store1']['authorizenet']['api_key'],
        :password => StoreConfig['Store1']['authorizenet']['secret'],
        :test => (not Rails.env.eql?('production'))
        )
      if not gateway
        raise AuthenticationFailed, 'Authentication with CIM Gateway could not be completed.'
      end
      return gateway
    end
  end
end