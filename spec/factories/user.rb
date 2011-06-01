Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.define :user do |user|
  user.add_attribute :email, Factory.next(:email)
end