class Store < ActiveRecord::Base
  belongs_to :user

  has_one :authorize_net
  has_many :plans
  has_many :payment_plans
  has_many :customers

  validates_associated :user
  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :create_default_plan
  
  def create_default_plan
    Plan.create({
      :name               => 'One payment',
      :payments_count     => 1,
      :includes_shipping  => false,
      :includes_tax       => false,
      :interest           => 0,
      :late_fee           => 0,
      :plan_type          => 'By price',
      :min_price          => 0,
      :max_price          => 100000,
      :store_id           => self.id,
      :frequency          =>'none',
      :is_readonly        => true
    })
  end
  
  def total_revenue
    return Store.sum(:payment,:joins=>{:payment_plans=>:payments}, :conditions => {:payments => {:status => Payment::AUTHORISED},:stores => {:id => self.id}})
  end
  
  def total_revenue_today
  	Store.sum(:payment,:joins=>{:payment_plans=>:payments}, :conditions => {:payments => {:status => Payment::AUTHORISED,:created_at=>Time.now.beginning_of_day() .. Time.now.end_of_day()},:stores => {:id => self.id}})
  end
  
end
