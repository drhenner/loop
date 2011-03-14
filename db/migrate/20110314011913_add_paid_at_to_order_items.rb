class AddPaidAtToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :paid_at, :datetime

    add_index :order_items, :paid_at
  end

  def self.down
    remove_column :order_items, :paid_at
  end
end
