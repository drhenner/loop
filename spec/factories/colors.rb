# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.sequence :color_name do |n|
  "color_name#{n}"
end

Factory.define :color do |f|
  f.name            {Factory.next(:color_name)}
end