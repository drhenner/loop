# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :owner do |f|
  f.company         { Factory(:company)}
  f.name "MyString"
  f.brief_description "MyText"
  f.full_description "MyText"
end