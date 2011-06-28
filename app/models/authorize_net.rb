class AuthorizeNet < ActiveRecord::Base
  belongs_to :store

  validates_associated :store
  validates_presence_of :api_login_id
  validates_presence_of :transaction_key
  validates_uniqueness_of :transaction_key, :scope => :api_login_id
  validates_uniqueness_of :api_login_id, :scope => :store_id
end
