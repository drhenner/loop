# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :ticket do |f|
  f.subject   "MyString"
  f.status    "new"
  f.details   "MyText needs to be at least 16 chars"
  f.user        { |c| c.association(:user) }
  f.assigned_to { |c| c.association(:user) }
  f.brand       { |c| c.association(:brand) }
  f.issue_type  "seller_admin"
  f.active      true
end