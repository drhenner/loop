class AddProductTypeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :product_type, :string, :default => 'boutique'
  end

  def self.down
    remove_column :products, :product_type
  end
end
