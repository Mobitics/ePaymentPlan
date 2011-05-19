StoreConfig = YAML.load_file(File.open("#{Rails.root}/config/stores.yml"))
ShopifyAPI::Session.setup({:api_key => StoreConfig[:Store1][:shopify][:api_key],
                           :secret => StoreConfig[:Store1][:shopify][:secret]
                         })