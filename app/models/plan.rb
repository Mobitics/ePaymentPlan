class Plan < ActiveRecord::Base
  # belongs_to :merchant, :class_name => "User", :foreign_key => :merchant_id
  belongs_to :store

  validates_associated :store
  validates_presence_of :name, :payments_count, :interest, :late_fee, :store_id
  validates_presence_of :min_price, :max_price, :if => :by_price
  #validates_presence_of :product_id, :if => :by_product
  validates_uniqueness_of :name, :scope => :store_id
  
  PLAN_TYPES = {'by_price' => 'By price', 'by_product' => 'By product'}

  def by_price
    self.plan_type.eql? "by_price"
  end
  
  def by_product
    self.plan_type.eql? "by_product"
  end
  
  def type
    PLAN_TYPES[self.plan_type]
  end

  def to_pay(amount=0)
    payment = amount.to_f / self.payments_count.to_f
    interests = payment / (1.0 - (self.interest.to_f / 100.to_f))
    (payment + interests)
  end
end
