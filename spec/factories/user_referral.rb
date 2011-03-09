# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user_referral do |f|
  f.user                  { |c| c.association(:user) }
  #f.referral_id 1
  f.referral_program_id 1
  f.referral_email      "valid@email.com"
  #f.purchased_at        "2011-03-09 05:39:54"
  f.sent_at             "2011-03-09 05:39:54"
end

Factory.define :referred_user_referral, :parent => :user_referral do |f|
  f.referral              { |c| c.association(:user) }
  f.referral_program_id   1
  f.referral_email        "valid@email.com"
  f.purchased_at          "2011-03-09 05:39:54"
  f.sent_at               "2011-03-09 05:39:54"
end