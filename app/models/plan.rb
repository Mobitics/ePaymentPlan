class Plan < ActiveRecord::Base
  validates_presence_of :name, :payments_count, :interest, :late_fee
  validates_presence_of :min_price, :max_price, :if => :by_price
  #validates_presence_of :product_id, :if => :by_product
  
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

end
