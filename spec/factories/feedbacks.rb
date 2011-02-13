# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :feedback do |f|
  f.user_id 1
  f.title   "Feedback Title"
  f.name    "John Doe"
  f.content "MyText"
  f.email   "drhenner@ymail.com"
  f.website "www.ror-e.com"
  f.user_ip     "192.168.1.1"
  f.permalink   "MyString"
  f.user_agent  "MyString"
  f.referrer    "MyString"
end

Factory.define :seller_feedback, :parent => :feedback do |f|

end

Factory.define :customer_service_feedback, :parent => :feedback do |f|

end
