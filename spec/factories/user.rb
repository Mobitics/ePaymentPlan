Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.define :user do |user|
  user.email {Factory.next(:email)}
  user.password {"password"}
end

Factory.define :merchant, :parent => :user do |merchant|
  merchant.after_create { |m| m.roles << Factory(:role)}
end

Factory.define :user_with_payment_profile, :parent => :user do |user|
  user.after_create { |u| Factory(:payment_profile, :user => u)}
end

Factory.define :merchant_with_plan, :parent => :merchant do |user|
  user.after_create { |u| Factory(:plan, :merchant => u)}
end