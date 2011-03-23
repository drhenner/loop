class AddCcInfoToPaymentProfile < ActiveRecord::Migration
  def self.up
    add_column :payment_profiles, :encrypted_last_digits, :string,  :length => 8
    add_column :payment_profiles, :encrypted_month,       :string,  :length => 200
    add_column :payment_profiles, :encrypted_year,        :string,  :length => 200
    add_column :payment_profiles, :cc_type,               :string,  :length => 30
    add_column :payment_profiles, :encrypted_number,      :string,  :length => 200
    add_column :payment_profiles, :encrypted_first_name,  :string,  :length => 200
    add_column :payment_profiles, :encrypted_last_name,   :string,  :length => 200
    add_column :payment_profiles, :encrypted_cvv,         :string,  :length => 200
    add_column :payment_profiles, :card_name,             :string,  :length => 120
  end

  def self.down
    remove_column :payment_profiles, :encrypted_last_digits
    remove_column :payment_profiles, :encrypted_month
    remove_column :payment_profiles, :encrypted_year
    remove_column :payment_profiles, :cc_type
    remove_column :payment_profiles, :encrypted_number
    remove_column :payment_profiles, :encrypted_first_name
    remove_column :payment_profiles, :encrypted_last_name
    remove_column :payment_profiles, :encrypted_cvv
    remove_column :payment_profiles, :card_name
  end
end
