
Factory.sequence :sku do |i|
  "345-98765-097#{i}"
end

Factory.define :variant do |f|
  #f.sku           '345-98765-0987'
  f.sku         { Factory.next(:sku) }
  f.product       { |c| c.association(:product) }
  f.color       { |c| c.association(:color) }
  f.brand       { |c| c.association(:brand) }
  f.price  11.00
  f.cost          8.00
  f.deleted_at    nil
  f.master        false
  f.count_on_hand             10000
  f.count_pending_to_customer 1000
  f.count_pending_from_supplier 900
end


Factory.define :five_dollar_variant, :class => Variant do |f| # :parent => :variant,
  f.price  5.00
  f.sku           '345-98765-0980'
  f.product       { |c| c.association(:product) }
  f.brand       { |c| c.association(:brand) }
  f.cost          3.00
  f.deleted_at    nil
  f.master        false
  f.count_on_hand             10000
  f.count_pending_to_customer 1000
  f.count_pending_from_supplier 900
end