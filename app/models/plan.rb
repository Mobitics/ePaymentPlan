class Plan < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates_presence_of :payments_count, :interest, :late_fee, :merchant_id
  validates_presence_of :min_price, :max_price, :if => :by_price
  #validates_presence_of :product_id, :if => :by_product
  
  belongs_to :merchant, :class_name => "User", :foreign_key => :merchant_id
  
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
    interests = payment * (self.interest.to_f / 100.to_f)
    (payment + interests)
  end
end
