class ReferralProgram < ActiveRecord::Base

  validates :name,  :presence => true,
                    :uniqueness => true,##  This should be done at the DB this is too expensive in rails
                    :length     => { :maximum => 50 }
  validates :gift_amount,  :presence => true

  CURRENT_REFERRAL_PROGRAM_ID = 1
  
  def self.current_program_id
    CURRENT_REFERRAL_PROGRAM_ID
  end
end
