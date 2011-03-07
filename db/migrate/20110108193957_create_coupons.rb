class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :type,                   :null => false
      t.string :code,                   :null => false
      t.decimal :amount,        :precision => 8, :scale => 2, :default => 0
      t.decimal :minimum_value, :precision => 8, :scale => 2
      t.integer :percent,   :default => 0
      t.text :description,              :null => false
      t.boolean :combine,   :default => false
      t.datetime :starts_at
      t.datetime :expires_at

      t.timestamps
    end

    #add_index :coupons, :code
    execute('CREATE INDEX coupons_code_ten ON coupons (code(8));')
    #execute('CREATE INDEX coupons_expires_at_ten ON coupons (expires_at(10));')
    add_index :coupons, :expires_at

  end

  def self.down
    drop_table :coupons
  end
end
