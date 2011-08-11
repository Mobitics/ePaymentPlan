AuthorizeConfig = YAML.load_file(File.open("#{Rails.root}/config/stores.yml"))

ActiveMerchant::Billing::Base.mode = :test # unless Rails.env.production?

module ActiveMerchant
  module Utils
    def get_payment_gateway(api_key=nil, secret=nil, test_mode=false)
      gateway = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
        :login => api_key || AuthorizeConfig['Store1']['authorizenet']['api_key'],
        :password => secret || AuthorizeConfig['Store1']['authorizenet']['secret'],
        :test => test_mode
      )
      if not gateway
        raise AuthenticationFailed, 'Authentication with CIM Gateway could not be completed.'
      end
      return gateway
    end
  end
end
