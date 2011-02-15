# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :company do |f|
  f.name "Nike"
  f.label "Just Do it!"
  f.brief_description "shoe company"
  f.full_description "We sell Tiger Woods stuff and much much more."
end