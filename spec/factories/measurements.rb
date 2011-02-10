# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :measurement do |f|
  f.user_id 1
  f.shoe_size "9.99"
  f.waist "9.99"
  f.pant_length 1
  f.dress_size 1
  f.shirt_size "MyString"
end