Factory.sequence :number do |i|
  i
end

Factory.define :order do |u|
  u.number          { Factory.next(:number) }
  u.email           'email@e.com'
  u.state           'in_progress'
  u.user            { |c| c.association(:user) }
  u.bill_address    { |c| c.association(:address) }
  u.ship_address    { |c| c.association(:address) }
  u.active          true
  u.calculated_at   Time.now
  u.completed_at    Time.now
end

Factory.define :in_progress_order, :parent => :order do |u|
  u.state           'in_progress'
end

Factory.define :complete_order, :parent => :order do |u|
  u.state           'complete'
end

Factory.define :order_with_an_item, :parent => :order do |f|
  f.order_items     { |c| [c.association(:order_item)] }
end
