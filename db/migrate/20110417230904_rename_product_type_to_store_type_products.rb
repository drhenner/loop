class RenameProductTypeToStoreTypeProducts < ActiveRecord::Migration
  def self.up
    rename_column :products, :product_type, :store_type
  end

  def self.down
    rename_column :products, :store_type, :product_type
  end
end
