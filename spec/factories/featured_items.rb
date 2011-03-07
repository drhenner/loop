# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :featured_item do |f|
  f.product     { |c| c.association(:product) }
  f.starts_at   "2011-03-07 00:00:00"
  f.ends_at     "2011-03-07 23:59:59"
end