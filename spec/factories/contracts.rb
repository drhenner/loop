# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contract do |f|
  f.name          "A Contracts name."
  f.brand         { |c| c.association(:brand) }
  f.flash_percent "9.99"
  f.store_percent "9.99"
  f.start_date    "2011-03-26"
  f.end_date      "2028-03-26"
end