class CreateProductColors < ActiveRecord::Migration
  def self.up
    create_table :product_colors do |t|
      t.integer :color_id,    :null => false
      t.integer :product_id,  :null => false

    end
    add_index :product_colors, :color_id
    add_index :product_colors, :product_id
  end

  def self.down
    drop_table :product_colors
  end
end
