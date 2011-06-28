class Store < ActiveRecord::Base
  belongs_to :user

  has_one :authorize_net
  has_many :plans
  has_many :payment_plans

  validates_associated :user
  validates_presence_of :name
  validates_uniqueness_of :name
end
