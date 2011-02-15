
Factory.define :brand do |u|
  u.company         { Factory(:company)}
  u.name            'Brand Name'
end