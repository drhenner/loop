
Factory.sequence :email do |n|
  "person#{n}@example.com"
end
# USER

Factory.define :user do |s|
  s.first_name  'John'
  s.last_name   'Doe'
  s.email       { Factory.next(:email) }
  s.password              'pasword'
  s.password_confirmation "pasword"
end

Factory.define :registered_user, :parent => :user do |s|
  s.state    'registered'
  s.birth_date  Time.now.to_date
end

Factory.define :registered_user_with_credit, :parent => :registered_user do |s|
  s.state    'registered_with_credit'
end


Factory.define :admin_user, :parent => :user do |f|
  f.roles     { [Role.find_by_name('administrator')] }
end

Factory.define :seller_admin_user, :parent => :user do |f|
  f.roles     { [Role.find_by_name('seller_admin')] }
  f.company   { Factory(:company)}
end

Factory.define :user_with_referral, :parent => :user do |f|
  f.user_referrals     { [Factory(:user_referral, :user_id => f.id )] }
end



Factory.define :super_admin_user, :parent => :user do |f|
  f.roles     { [Role.find_by_name('super_administrator')] }
end
