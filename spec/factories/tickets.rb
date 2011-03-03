# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :ticket do |f|
  f.subject "MyString"
  f.status "MyString"
  f.details "MyText"
  f.user_id 1
  f.brand_id 1
  f.issue_type "MyString"
  f.active false
end