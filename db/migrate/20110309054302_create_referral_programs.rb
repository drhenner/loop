class CreateReferralPrograms < ActiveRecord::Migration
  def self.up
    create_table :referral_programs do |t|
      t.string :name,  :null => false
      t.decimal :gift_amount, :precision => 8, :scale => 2, :default => 1.0,  :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :referral_programs
  end
end
