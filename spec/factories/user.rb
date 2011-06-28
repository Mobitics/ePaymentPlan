Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.define :user do |user|
  user.email {Factory.next(:email)}
  user.password {"password"}
  user.association :store
end

Factory.define :store, :parent => :user do |store|
  store.after_create { |s| s.roles << Factory(:role)}
end

Factory.define :user_with_payment_profile, :parent => :user do |user|
  user.after_create { |u| Factory(:payment_profile, :user => u)}
end

Factory.define :store_with_plan, :parent => :store do |user|
  user.after_create { |u| Factory(:plan, :store => u)}
end