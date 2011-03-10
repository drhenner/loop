class CreateUserReferrals < ActiveRecord::Migration
  def self.up
    create_table :user_referrals do |t|
      t.integer :user_id
      t.integer :referral_id
      t.integer :referral_program_id
      t.string :referral_email
      t.datetime :purchased_at
      t.datetime :sent_at

      t.timestamps
    end
    add_index :user_referrals, :user_id
    add_index :user_referrals, :referral_id
    add_index :user_referrals, :referral_program_id
    execute('CREATE INDEX user_referrals_referral_email_ten ON user_referrals (referral_email(9));')
  end

  def self.down
    drop_table :friendships
  end
end
