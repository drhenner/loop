class ReferralProgram < ActiveRecord::Base

  validates :name,  :presence => true,
                    :uniqueness => true,##  This should be done at the DB this is too expensive in rails
                    :length     => { :maximum => 50 }
  validates :gift_amount,  :presence => true
end
