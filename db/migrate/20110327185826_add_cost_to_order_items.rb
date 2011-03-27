class AddCostToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :cost, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :order_items, :cost
  end
end
