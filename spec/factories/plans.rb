Factory.sequence :plan_name do |n|
  "My Plan #{n}"
end

Factory.define :plan do |plan|
  plan.add_attribute :name, Factory.next(:plan_name)
  plan.add_attribute :payments_count, 10
  plan.add_attribute :includes_shipping, true
  plan.add_attribute :includes_tax, false
  plan.add_attribute :interest, 10
  plan.add_attribute :late_fee, 15
  plan.add_attribute :plan_type, 'by_price'
  plan.add_attribute :min_price, 100
  plan.add_attribute :max_price, 500
end