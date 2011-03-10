class UserReferral < ActiveRecord::Base
  belongs_to :user
  belongs_to :referral, :class_name => "User", :foreign_key => "referral_id"


  validates :referral_program_id, :presence => true
  validates :user_id,             :presence => true

  validates :referral_email,      :presence => true,
                                  :uniqueness => true,##  This should be done at the DB this is too expensive in rails
                                  :format     => { :with => CustomValidators::Emails.email_validator },
                                  :length     => { :maximum => 255 }

  def signed_up
    referral_id? ? 'Yes' : 'No'
  end
  def display_purchased
    purchased_at? ? 'Yes' : 'No'
  end
end
