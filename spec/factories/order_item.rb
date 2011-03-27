
Factory.define :order_item do |u|
  u.price         3.00
  u.cost          2.00
  u.total         3.15
  u.order         { |c| c.association(:order) }
  u.variant       { |c| c.association(:variant) }
  u.tax_rate      { |c| c.association(:tax_rate) }
  u.shipping_rate { |c| c.association(:shipping_rate) }
  #u.shipment      { |c| c.association(:shipment) }

end

Factory.define :order_item_with_shipment, :parent => :order_item do |u|

  u.shipment      { |c| c.association(:shipment) }

end


