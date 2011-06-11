Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.define :user do |user|
  user.email {Factory.next(:email)}
  user.password {"password"}
end

Factory.define :user_with_payment_profile, :parent => :user do |user|
  user.after_create { |u| Factory(:payment_profile, :user => u)}  
end