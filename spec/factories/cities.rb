# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :city do |f|
  f.name      'New York'
  f.state     { State.first }
  f.latitude  "119.99"
  f.longitude "159.09"
end